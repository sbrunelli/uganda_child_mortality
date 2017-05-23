import numpy as np

class Sampler(object):

    def __init__(self, replacement=False):
        self.replacement = replacement

    def bootstrap(self, X):
        return np.random.choice(X.shape[0], X.shape[0], replace=self.replacement)

    def div_count_pos_neg_indices(self, X, y):
        negatives, positives = y==0, y==1
        negative_count, positive_count = np.sum(negatives), np.sum(positives)
        r = np.array(range(len(negatives)))
        negative_indices = r[negatives]
        r = np.array(range(len(positives)))
        positive_indices = r[positives]
        return negative_count, positive_count, negative_indices, positive_indices

    def undersample(self, X, y, indices, tp):
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
