import numpy as np
from sklearn.linear_model import LogisticRegression
from sklearn.ensemble import RandomForestClassifier, AdaBoostClassifier, GradientBoostingClassifier
from sklearn.svm import SVC
from sklearn.model_selection import cross_val_score, GridSearchCV, train_test_split
from sklearn.metrics import classification_report, precision_score, recall_score
from imblearn.over_sampling import RandomOverSampler
from balanced_bagging import BalancedBaggingClassifier

class BuildModel(object):

    def __init__(self, X, y, oversample_ratio=0.35):
        self._classifiers = [LogisticRegression(),
                            RandomForestClassifier(),
                            AdaBoostClassifier(),
                            GradientBoostingClassifier(),
                            SVC(C=1),
                            BalancedBaggingClassifier()]
        self._X = X
        self._y = y
        self._oversample_ratio = oversample_ratio

    def cross_validate(self):
        scores = []
        for classifier in self._classifiers:
            cv_score = cross_val_score(classifier, self._X, self._y, cv=5, scoring='recall')
            scores.append((str(classifier.__class__).split("'")[1].split('.')[-1], cv_score))
        return scores

    def compare_models(self):
        scores = self.cross_validate()
        return scores

    # def features_importance(self):
    #     '''
    #     Run random forest classifier with all available features and prints a report
    #     of the feature importances
    #     '''
    #     clf = RandomForestClassifier(n_estimators=1000)
    #     scores = cross_val_score(clf, self._X, self._y, cv=5, scoring='recall')
    #     features_importances = clf.fit(self._X, self._y).feature_importances_
    #     return np.mean(scores), features_importances

    def features_importance(self):
        X_train, X_test, y_train, y_test = train_test_split(self._X, self._y, test_size=0.5)
        ros = RandomOverSampler()
        X_oversampled, y_oversampled = ros.fit_sample(X_train, y_train)
        tuned_parameters = [
            {
                'n_estimators': [10, 100, 1000],
                'min_samples_split': [2, 5]
            }
        ]
        print '# Tuning hyperparameters'
        clf = GridSearchCV(RandomForestClassifier(n_jobs=-1), tuned_parameters, cv=5, scoring='recall_macro')
        clf.fit(X_oversampled, y_oversampled)
        print 'Best parameters:'
        print
        print clf.best_params_
        print
        print 'Grid scores on training set:'
        print
        means = clf.cv_results_['mean_test_score']
        stds = clf.cv_results_['std_test_score']
        for mean, std, params in zip(means, stds, clf.cv_results_['params']):
            print '%0.3f (+/-%0.03f) for %r' % (mean, std, params)
        print
        print 'Detailed classification report:'
        print
        y_true, y_pred = y_test, clf.predict(X_test)
        print precision_score(y_true, y_pred), recall_score(y_true, y_pred)
        print 'Feature importance:'
        return means, clf.best_estimator_.feature_importances_



    def oversample(self):
        print '\n\nOversampling minority class'
        print '---------------------------'
        print 'Original dataset minority class proportion: {:2.3f}'.format(np.mean(self._y))
        ros = RandomOverSampler()
        self._X, self._y = ros.fit_sample(self._X, self._y)
        print 'Resampled dataset minority class proportion: {:2.3f}'.format(np.mean(self._y))
