# -*- coding: utf-8 -*-

from sklearn.svm import LinearSVC
from sklearn.ensemble import AdaBoostClassifier
from sklearn.ensemble import ExtraTreesClassifier
from sklearn.ensemble import GradientBoostingClassifier
from sklearn.ensemble import RandomForestClassifier

from sklearn.decomposition import TruncatedSVD
from sklearn import datasets
from sklearn.cross_validation import cross_val_score

iris = datasets.load_iris()
features = iris.data  # 特徴量
labels = iris.target  # 正解

# 特徴量の次元を圧縮
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
