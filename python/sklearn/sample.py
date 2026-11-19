# -*- coding: utf-8 -*-
# sample.py: Ensemble classifiers compared on iris
#
# Description:
# Compare ensemble classifiers on the iris data set by cross validation score.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 sample.py
#
# Requirements:
# - Python 3
# - scikit-learn before 0.20, which still provides sklearn.cross_validation
#

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
