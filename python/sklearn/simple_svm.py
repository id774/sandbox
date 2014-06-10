# -*- coding: utf-8 -*-

import numpy as np
from sklearn.cluster import KMeans
from sklearn import svm

train_X = np.genfromtxt('data.csv', delimiter=',')
kmeans_model = KMeans(n_clusters=3, random_state=10).fit(train_X)
labels = kmeans_model.labels_

clf = svm.SVC(kernel='rbf', C=1)

clf.fit(train_X, labels)

test_X = np.genfromtxt('test.csv', delimiter=',')

results = clf.predict(test_X)

ranks = []
for result, feature in zip(results, test_X):
    ranks.append([result, feature, feature.sum()])

ranks.sort(key=lambda x:(-x[2]))

for rank in ranks:
    print(rank)

