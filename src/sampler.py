import numpy as np

class Sampler(object):
"""
This class provides all the sampling methods.
"""

    def __init__(self, replacement=False):
        self.replacement = replacement

    def bootstrap(self, X):
        """
        Bootstrap sampler.

        Parameters
        ----------
        X: array-like matrix to be sampled.

        Returns
        -------
        bootstrap_indices: 1-d numpy array of indices of X.
            This array has size the numer of rows in X.
            The sampling is made with or without replacement depending upon the value of the class parameter replacement.
        """
        bootstrap_indices = np.random.choice(X.shape[0], X.shape[0], replace=self.replacement)
        return bootstrap_indices

    def div_count_pos_neg_indices(self, X, y):
        """Helper function to divide X & y into positive and negative classes
        and counts up the number in each.

        Parameters
        ----------
        X : ndarray - 2D
        y : ndarray - 1D

        Returns
        -------
        negative_count      : Int
        positive_count      : Int
        negative_indices    : ndarray - 1D
        positive_indices    : ndarray - 1D
        """
        negatives, positives = y==0, y==1
        negative_count, positive_count = np.sum(negatives), np.sum(positives)
        r = np.array(range(len(negatives)))
        negative_indices = r[negatives]
        r = np.array(range(len(positives)))
        positive_indices = r[positives]
        return negative_count, positive_count, negative_indices, positive_indices

    def undersample(self, X, y, indices, tp):
        """Randomly discards negative observations from X & y to achieve the
        target proportion of positive to negative observations.

        Parameters
        ----------
        X       : ndarray - 2D
        y       : ndarray - 1D
        indices : ndarray - 1D
        tp      : float - range [0.5, 1], target proportion of positive class observations

        Returns
        -------
        undersampled_indices : ndarray - 1D
        """
        if tp < np.mean(y):
            return X, y
        neg_count, pos_count, neg_indices, pos_indices = self.div_count_pos_neg_indices(X, y)
        negative_sample_rate = (pos_count * (1 - tp)) / (neg_count * tp)
        negative_keepers = np.random.choice(a=[False,True], size=neg_count,
                                            p=[1-negative_sample_rate,
                                                negative_sample_rate])
        negatives_undersampled_indices = neg_indices[negative_keepers]
        positves_resampled_indices = np.random.choice(pos_indices, pos_count, replace=self.replacement)
        undersampled_indices = np.concatenate((negatives_undersampled_indices, positves_resampled_indices))
        np.random.shuffle(undersampled_indices)
        return undersampled_indices
