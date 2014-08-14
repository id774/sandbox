# -*- coding: utf-8 -*-

from sklearn import metrics
from sklearn.metrics import pairwise_distances
from sklearn import datasets

dataset = datasets.load_iris()
X = dataset.data
y = dataset.target

print('X')
print(X)
print('y')
print(y)

labels_true = [0, 0, 0, 1, 1, 1]
labels_pred = [0, 0, 1, 1, 2, 2]

print('metrics.adjusted_mutual_info_score(labels_true, labels_pred)')
print(metrics.adjusted_mutual_info_score(labels_true, labels_pred))

labels_true = [0, 1, 2, 0, 3, 4, 5, 1]
labels_pred = [1, 1, 0, 0, 2, 2, 2, 2]

print('metrics.adjusted_mutual_info_score(labels_true, labels_pred)')
print(metrics.adjusted_mutual_info_score(labels_true, labels_pred))

labels_true = [0, 0, 0, 1, 1, 1]
labels_pred = [0, 0, 1, 1, 2, 2]

print('metrics.homogeneity_score(labels_true, labels_pred)')
print(metrics.homogeneity_score(labels_true, labels_pred))
print('metrics.completeness_score(labels_true, labels_pred)')
print(metrics.completeness_score(labels_true, labels_pred))
