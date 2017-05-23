from data_preparation import DataPreparation
from model_selector import ModelSelector
from sklearn.model_selection import train_test_split
import numpy as np
import pandas as pd
from datetime import datetime



def main():
    ################################
    #
    #   DATA PREPARATION
    #
    ################################
    # Data cleaning
    dp = DataPreparation()

    # X, y data for modeling
    X, y = dp.clean()
    variable_names = dp.get_original_variable_names()
    print
    print
    print ' >>>>DATA PREPARATION<<<<'
    print ' Data preparation | Features: {:s}'.format(variable_names)

    # Train / test split
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=99)
    print ' Data preparation |'
    print ' Data preparation | Original sample size: {:d}'.format(X.shape[0])
    print ' Data preparation | Training sample size: {:d}'.format(X_train.shape[0])
    print ' Data preparation | Test sample size: {:d}'.format(X_test.shape[0])
    print ' Data preparation | '
    print ' Data preparation | Original death incidence: {:2.3f}'.format(np.mean(y))
    print ' Data preparation | Train set death incidence: {:2.3f}'.format(np.mean(y_train))
    print ' Data preparation | Test set death incidence: {:2.3f}'.format(np.mean(y_test))

    ################################
    #
    #   MODEL BUILDING
    #
    ################################
    # Grid search CV best model
    print
    print ' >>>>MODEL SELECTION<<<<'
    ms = ModelSelector(num_folds=5)
    scores = ms.grid_search_cv(X_train, y_train)

    timestmp = datetime.now().strftime('%Y%m%d_%H%M')
    scores.to_csv('./data/scores_'+timestmp+'.csv', index=False)

    # Train best models against entire training set
    # and plot thier ROC curves
    ms.plot_roc_curves(X_test, y_test)

    # # Calibrate probabilities
    #
    # # Score best model against hold out data set
    return scores


if __name__ == "__main__":
    scores = main()
