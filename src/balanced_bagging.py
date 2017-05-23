from sklearn.tree import DecisionTreeClassifier
from sampler import Sampler
from sklearn.metrics import accuracy_score, recall_score, precision_score
import numpy as np
from sklearn import base

class BalancedBaggingClassifier(base.BaseEstimator):

    def __init__(self,
                    n_estimators=10,
                    sampling_strategy='balanced',
                    sample_with_replacement=False,
                    oob_score=False,
                    undersample_proportion=0.35):
        self.n_estimators=n_estimators
        self.estimators_ = []
        self.sampling_strategy = sampling_strategy
        self.sample_with_replacement = sample_with_replacement
        self.X = None
        self.y = None
        self.sample_indices = []
        self.sample_minority_class_proportions = []
        self.oob_score = oob_score
        self.oob_score_ = []
        self.undersample_proportion = undersample_proportion

    def _oob_score(self, estimator, idx):
        oob_indices = np.setdiff1d(np.arange(self.X.shape[0]), self.sample_indices[idx])
        oob_predictions = estimator.predict(self.X[oob_indices])
        oob_accuracy = accuracy_score(self.y[oob_indices], oob_predictions)
        oob_recall = recall_score(self.y[oob_indices], oob_predictions)
        oob_precision = precision_score(self.y[oob_indices], oob_predictions)
        return oob_accuracy, oob_recall, oob_precision

    def fit(self, X, y):
        self.X = X
        self.y = y
        self.sample_indices = []

        sampler = Sampler(self.sample_with_replacement)

        # For each estimator
        for idx in xrange(self.n_estimators):
            # Instantiate estimator
            est = DecisionTreeClassifier()

            # Take bootstrap sample from X, y
            bootstrap_indices = sampler.bootstrap(self.X)

            # Balance the sample by downsampling
            sample_indices = sampler.undersample(self.X, self.y,
                                                            bootstrap_indices,
                                                            self.undersample_proportion)
            self.sample_indices.append(sample_indices)

            # Stores minority class proportion for current learner
            self.sample_minority_class_proportions.append(np.mean(self.y[sample_indices]))

            # Fit estimator
            est.fit(X[self.sample_indices[idx]], y[self.sample_indices[idx]])

            # Calculate oob_score if necessary
            if (self.oob_score) & (self.sample_with_replacement):
                oob_accuracy, oob_recall, oob_precision = self._oob_score(est, idx)
                self.oob_score_.append((oob_accuracy, oob_recall, oob_precision))

            # Store estimator in the ensemble
            self.estimators_.append(est)

    def get_minority_class_proportions(self):
        return self.sample_minority_class_proportions

    def predict(self, X):
        y_predicted_all = []
        for idx in xrange(self.n_estimators):
            y_predicted_all.append(self.estimators_[idx].predict(X))
        y_predicted = np.trunc(0.5 + np.mean(y_predicted_all, axis=0))
        return y_predicted

    def predict_proba(self, X):
        predict_proba_all = []
        for idx in xrange(self.n_estimators):
            predict_proba_all.append(self.estimators_[idx].predict_proba(X))
        return np.mean(predict_proba_all, axis=0)

    def score(self, X, y):
        y_predicted = self.predict(X)
        return np.mean(y==y_predicted)
