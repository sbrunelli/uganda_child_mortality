import numpy as np
import pandas as pd
from sklearn.linear_model import LogisticRegression
from sklearn.ensemble import RandomForestClassifier, AdaBoostClassifier, GradientBoostingClassifier
from sklearn.svm import SVC
from sklearn.metrics import classification_report, precision_score, recall_score, f1_score, roc_curve, auc
from imblearn.over_sampling import RandomOverSampler
from imblearn.under_sampling import RandomUnderSampler
from balanced_bagging import BalancedBaggingClassifier
from itertools import product, izip
import json
import matplotlib.pyplot as plt
from datetime import datetime

from time import sleep

class ModelSelector(object):

    def __init__(self, num_folds=5):
        self._classifiers = [
                                # LogisticRegression(),
                                RandomForestClassifier(n_jobs=-1),
                                AdaBoostClassifier(),
                                GradientBoostingClassifier()#,
                                # SVC(C=1)
                            ]
        self._strategies = ['oversample', 'undersample']
        self._sample_rates = np.linspace(0.1, 0.5, 5)
        self._num_folds = num_folds
        self._folds = []
        self.X = None       # Training desing matrix
        self.y = None       # Training response variable
        self._grid_search = None
        self.grid_search_scores = None
        self._best_classifiers = []
        self._plot_colors_palette = ['royalblue', 'darkorange', 'darkgrey', 'limegreen', 'darkmagenta', 'teal']

    def _get_classifier_name(self, classifier):
        return str(classifier.__class__).split("'")[1].split('.')[-1]

    def _import_grid_search(self):
        json_file = open('params/grid_search.json').read()
        self._grid_search = json.loads(json_file)

    def _make_none_parameters_values(self, classifier_values_product):
        res = []
        for classifier_value_product in classifier_values_product:
            param_values = []
            for idx in xrange(len(classifier_value_product)):
                v = classifier_value_product[idx]
                if v == 'None':
                    v = None
                param_values.append(v)
            res.append(tuple(param_values))
        return res

    def _create_grid_search_space(self, classifier):
        classifier_grid = self._grid_search[classifier]
        classifier_params = classifier_grid.keys()
        classifier_values = classifier_grid.values()

        classifier_values_product = list(product(*classifier_values))   #new
        # print classifier_values_product             # new
        classifier_values_product = self._make_none_parameters_values(classifier_values_product)    #new
        # print classifier_values_product # new
        # return classifier_params, list(product(*classifier_values))
        return classifier_params, classifier_values_product

    def _grid_search_cv_blagging(self):
        classifier = BalancedBaggingClassifier()
        classifier_name = self._get_classifier_name(classifier)
        print ' Model selection [{:s}] | Grid searching classifier: {:s}'.format(datetime.strftime(datetime.now(), "%Y%m%d_%H%M%S"), classifier_name)

        # For each combination of grid search parameters
        params, vals = self._create_grid_search_space(classifier_name)

        print ' Model selection [{:s}] | For parameters ({:s})'.format(datetime.strftime(datetime.now(), "%Y%m%d_%H%M%S"),params)

        scores = []
        # Hyperparameters grid-search loop
        for val in vals:
            print ' Model selection [{:s}] | Trying values: {:s}'.format(datetime.strftime(datetime.now(), "%Y%m%d_%H%M%S"),val)

            precisions = []
            recalls = []
            f1s = []

            # Folds loop
            for fold in xrange(self._num_folds):

                # Training set only consists of folds different than current fold
                X_train, y_train = self.X[self._folds != fold], self.y[self._folds != fold]

                # Apply current parameters to classifier
                classifier = classifier.set_params(**dict(izip(params, val)))
                # print
                # print
                # print params, val
                # print classifier

                # Fit classifier
                classifier.fit(X_train, y_train)

                # Predict
                y_predicted = classifier.predict(self.X[self._folds == fold])

                # Score
                precision = precision_score(self.y[self._folds == fold], y_predicted)
                recall = recall_score(self.y[self._folds == fold], y_predicted)
                f1 = f1_score(self.y[self._folds == fold], y_predicted)
                precisions.append(precision)
                recalls.append(recall)
                f1s.append(f1)

            grid_search_param_values = [str(el[0]) + ': ' + str(el[1]) for el in list(izip(params, val))]

            # Append grid search results
            scores.append(('undersample', dict(izip(params, val))['undersample_proportion'], classifier_name,
                        0, 0, grid_search_param_values,
                        np.mean(precisions), np.mean(recalls), np.mean(f1s),
                        np.std(precisions), np.std(recall), np.std(f1s)))


        return scores

    def grid_search_cv(self, X, y):
        # Store object state
        self.X = X
        self.y = y

        # Read grid search json file
        self._import_grid_search()

        # Create folds
        self._folds = np.random.choice(np.arange(self._num_folds), X.shape[0])

        # Multiply strategies hyperparameters to create all possible combinations
        strategy_hypeparameters = list(product(self._strategies, self._sample_rates))

        # Cross validation outer loop
        scores = []
        for strategy_name, sample_rate in strategy_hypeparameters:
            print ' Model selection [{:s}] | '.format(datetime.strftime(datetime.now(), "%Y%m%d_%H%M%S"))
            print ' Model selection [{:s}] | '.format(datetime.strftime(datetime.now(), "%Y%m%d_%H%M%S"))
            print ' Model selection [{:s}] | Strategy: {:s}'.format(datetime.strftime(datetime.now(), "%Y%m%d_%H%M%S"),strategy_name)
            print ' Model selection [{:s}] | Sample rate: {:2.2f}'.format(datetime.strftime(datetime.now(), "%Y%m%d_%H%M%S"),sample_rate)

            # For each classifier
            for classifier in self._classifiers:

                classifier_name = self._get_classifier_name(classifier)
                print ' Model selection [{:s}] | '.format(datetime.strftime(datetime.now(), "%Y%m%d_%H%M%S"))
                print ' Model selection [{:s}] | Grid searching classifier: {:s}'.format(datetime.strftime(datetime.now(), "%Y%m%d_%H%M%S"),classifier_name)

                # For each combination of grid search parameters
                params, vals = self._create_grid_search_space(classifier_name)

                print ' Model selection [{:s}] | For parameters ({:s})'.format(datetime.strftime(datetime.now(), "%Y%m%d_%H%M%S"),params)
                # Hyperparameters grid-search loop
                for val in vals:
                    print ' Model selection [{:s}] | Trying values: {:s}'.format(datetime.strftime(datetime.now(), "%Y%m%d_%H%M%S"),val)

                    precisions = []
                    recalls = []
                    f1s = []

                    # Folds loop
                    for fold in xrange(self._num_folds):

                        # Training set only consists of folds different than current fold
                        X_train, y_train = self.X[self._folds != fold], self.y[self._folds != fold]

                        # Apply sampling strategy to training set only
                        X_resampled, y_resampled = self._random_sampler(X_train, y_train, strategy_name, sample_rate)
                        sample_size = X_resampled.shape[0]
                        minority_class_prop = np.mean(y_resampled)

                        # Apply current parameters to classifier
                        classifier = classifier.set_params(**dict(izip(params, val)))
                        # print
                        # print
                        # print params, val
                        # print classifier

                        # Fit classifier
                        classifier.fit(X_resampled, y_resampled)

                        # Predict
                        y_predicted = classifier.predict(self.X[self._folds == fold])

                        # Score
                        precision = precision_score(self.y[self._folds == fold], y_predicted)
                        recall = recall_score(self.y[self._folds == fold], y_predicted)
                        f1 = f1_score(self.y[self._folds == fold], y_predicted)
                        precisions.append(precision)
                        recalls.append(recall)
                        f1s.append(f1)

                    grid_search_param_values = [str(el[0]) + ': ' + str(el[1]) for el in list(izip(params, val))]

                    # Append grid search results
                    scores.append((strategy_name, sample_rate, classifier_name,
                                sample_size, minority_class_prop, grid_search_param_values,
                                np.mean(precisions), np.mean(recalls), np.mean(f1s),
                                np.std(precisions), np.std(recall), np.std(f1s)))

        print ' Model selection [{:s}] | '.format(datetime.strftime(datetime.now(), "%Y%m%d_%H%M%S"))
        print ' Model selection [{:s}] | Custom classifiers'.format(datetime.strftime(datetime.now(), "%Y%m%d_%H%M%S"))
        scores_blagging = self._grid_search_cv_blagging()

        cnames = ['strategy_name', 'sample_rate', 'classifier_name', 'sample_size', 'minority_class_prop', 'grid_search_param_values', 'precision_mean', 'recall_mean', 'f1_mean', 'precision_stddev', 'recall_stddev', 'f1_stddev']

        scores_df = pd.DataFrame(scores, columns=cnames)
        scores_blagging_df = pd.DataFrame(scores_blagging, columns=cnames)
        scores = pd.concat([scores_df, scores_blagging_df])

        self.grid_search_scores = scores
        return self.grid_search_scores

    def _best_parameters_string2dict(self, best_params_string):
        best_parameters = dict()
        for param in best_params_string:
            k, v = param.split(':')
            if v.strip().isdigit():
                v = int(v)
            elif v.strip().replace('.','').isdigit():
                v = float(v)
            elif str(v.strip()) == 'None':
                v = None
            else:
                v = v.strip()
            best_parameters[k] = v
        return best_parameters

    def _retrain_balanced_bagging_with_best_parameters(self, classifier, metric='f1'):
        classifier_name = self._get_classifier_name(classifier)
        metric_cname = metric + '_mean'
        idx_best_params = np.argmax(self.grid_search_scores[self.grid_search_scores.classifier_name==classifier_name][metric_cname])
        best_params_string = self.grid_search_scores[self.grid_search_scores.classifier_name==classifier_name].iloc[idx_best_params]['grid_search_param_values']
        best_parameters = self._best_parameters_string2dict(best_params_string)

        # Apply sampling strategy to training set only
        print ' Model selection [{:s}] | '.format(datetime.strftime(datetime.now(), "%Y%m%d_%H%M%S"))
        print ' Model selection [{:s}] | Retraining classifier: {:s}'.format(datetime.strftime(datetime.now(), "%Y%m%d_%H%M%S"),classifier_name)
        print ' Model selection [{:s}] | Optimizing metric: {:s}'.format(datetime.strftime(datetime.now(), "%Y%m%d_%H%M%S"),metric)
        print ' Model selection [{:s}] | Best parameters: {:s}'.format(datetime.strftime(datetime.now(), "%Y%m%d_%H%M%S"),best_parameters)
        clf = classifier.set_params(**best_parameters)
        clf.fit(self.X, self.y)
        print ' Model selection [{:s}] | Minority class resampled proportion: {:2.3f}'.format(datetime.strftime(datetime.now(), "%Y%m%d_%H%M%S"),np.mean(clf.get_minority_class_proportions()))
        print clf
        return clf

    def _retrain_with_best_parameters(self, classifier, metric='f1'):
        classifier_name = self._get_classifier_name(classifier)
        metric_cname = metric + '_mean'
        idx_best_params = np.argmax(self.grid_search_scores[self.grid_search_scores.classifier_name==classifier_name][metric_cname])
        best_strategy = self.grid_search_scores.iloc[idx_best_params]['strategy_name']
        best_sample_rate = self.grid_search_scores.iloc[idx_best_params]['sample_rate']
        best_params_string = self.grid_search_scores.iloc[idx_best_params]['grid_search_param_values']
        best_parameters = self._best_parameters_string2dict(best_params_string)

        # Apply sampling strategy to training set only
        print ' Model selection [{:s}] | '.format(datetime.strftime(datetime.now(), "%Y%m%d_%H%M%S"))
        print ' Model selection [{:s}] | Retraining classifier: {:s}'.format(datetime.strftime(datetime.now(), "%Y%m%d_%H%M%S"),classifier_name)
        print ' Model selection [{:s}] | Optimizing metric: {:s}'.format(datetime.strftime(datetime.now(), "%Y%m%d_%H%M%S"),metric)
        print ' Model selection [{:s}] | Best strategy: {:s}'.format(datetime.strftime(datetime.now(), "%Y%m%d_%H%M%S"),best_strategy)
        print ' Model selection [{:s}] | Best sample rate: {:2.2f}'.format(datetime.strftime(datetime.now(), "%Y%m%d_%H%M%S"),best_sample_rate)
        print ' Model selection [{:s}] | Best parameters: {:s}'.format(datetime.strftime(datetime.now(), "%Y%m%d_%H%M%S"),best_parameters)
        X_resampled, y_resampled = self._random_sampler(self.X, self.y, best_strategy, best_sample_rate)
        print ' Model selection [{:s}] | Minority class resampled proportion: {:2.3f}'.format(datetime.strftime(datetime.now(), "%Y%m%d_%H%M%S"),np.mean(y_resampled))
        clf = classifier.set_params(**best_parameters)
        clf.fit(X_resampled, y_resampled)
        print clf
        return clf

    def plot_roc_curves(self, X_test, y_test):
        plt.title('Receiver Operating Characteristic')
        plt.plot([0, 1], [0, 1], 'r--')
        plt.xlim([0, 1])
        plt.ylim([0, 1])
        plt.ylabel('True Positive Rate')
        plt.xlabel('False Positive Rate')
        for idx, classifier in enumerate(self._classifiers):
            classifier_name = self._get_classifier_name(classifier)

            # Retrain with best parameters from grid search
            clf = self._retrain_with_best_parameters(classifier)

            # Plot its ROC curve
            probs = clf.predict_proba(X_test)
            preds = probs[:,1]
            fpr, tpr, threshold = roc_curve(y_test, preds)
            roc_auc = auc(fpr, tpr)

            plt.plot(fpr, tpr, 'b', label = classifier_name + ' AUC = %0.2f' % roc_auc, color = self._plot_colors_palette[idx])

        # Add BalancedBaggingClassifier to ROC
        classifier = self._retrain_balanced_bagging_with_best_parameters(BalancedBaggingClassifier())
        classifier_name = self._get_classifier_name(classifier)
        probs = classifier.predict_proba(X_test)
        preds = probs[:,1]
        fpr, tpr, threshold = roc_curve(y_test, preds)
        roc_auc = auc(fpr, tpr)

        plt.plot(fpr, tpr, 'b', label = classifier_name + ' AUC = %0.2f' % roc_auc, color = self._plot_colors_palette[idx+1])

        plt.legend()

        timestmp = datetime.now().strftime('%Y%m%d_%H%M')
        plt.savefig('./images/roc_' + timestmp + '.png')

    def _random_sampler(self, X, y, strategy, sample_ratio):
        if strategy=='oversample':
            ros = RandomOverSampler(ratio=sample_ratio)
            X_resampled, y_resampled = ros.fit_sample(X, y)
        else:
            rus = RandomUnderSampler(ratio=sample_ratio)
            X_resampled, y_resampled = rus.fit_sample(X, y)
        return X_resampled, y_resampled
