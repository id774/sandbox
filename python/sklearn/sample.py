# -*- coding: utf-8 -*-
# Compare ensemble classifiers on the iris data set by cross validation score.

from sklearn.svm import LinearSVC
from sklearn.ensemble import AdaBoostClassifier
from sklearn.ensemble import ExtraTreesClassifier
from sklearn.ensemble import GradientBoostingClassifier
from sklearn.ensemble import RandomForestClassifier

from sklearn.decomposition import TruncatedSVD
from sklearn import datasets
from sklearn.cross_validation import cross_val_score

iris = datasets.load_iris()
features = iris.data  # features
labels = iris.target  # correct labels

# Reduce the dimensionality of the features
lsa = TruncatedSVD(2)
reduced_features = lsa.fit_transform(features)

clf_instances = [
    LinearSVC(),
    AdaBoostClassifier(),
    ExtraTreesClassifier(),
    GradientBoostingClassifier(),
    RandomForestClassifier()
]

for clf in clf_instances:
    scores = cross_val_score(clf, reduced_features, labels, cv=5)
    score = sum(scores) / len(scores)
    print(clf)
    print(score)
