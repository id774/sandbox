# -*- coding: utf-8 -*-

from sklearn import metrics

labels_true = [0, 0, 0, 1, 1, 1]
labels_pred = [0, 0, 1, 1, 2, 2]
print ( metrics.adjusted_mutual_info_score(labels_true, labels_pred) )

labels_true = [0, 1, 2, 0, 3, 4, 5, 1]
labels_pred = [1, 1, 0, 0, 2, 2, 2, 2]

print ( metrics.adjusted_mutual_info_score(labels_true, labels_pred) )

labels_true = [0, 0, 0, 1, 1, 1]
labels_pred = [0, 0, 1, 1, 2, 2]

print ( metrics.homogeneity_score(labels_true, labels_pred) )
print ( metrics.completeness_score(labels_true, labels_pred) )

from sklearn import metrics
from sklearn.metrics import pairwise_distances
from sklearn import datasets

dataset = datasets.load_iris()
X = dataset.data
y = dataset.target

print (X)
print (y)

import numpy as np
from sklearn.cluster import KMeans

kmeans_model = KMeans(n_clusters=3, random_state=1).fit(X)
labels = kmeans_model.labels_
print ( metrics.silhouette_score(X, labels, metric='euclidean') )

import sys, os
import codecs
import numpy as np

from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.cluster import KMeans, MiniBatchKMeans
from sklearn.decomposition import TruncatedSVD
from sklearn.preprocessing import Normalizer

def make_cluster(datasets):
    num_clusters = 5
    lsa_dim = 500
    max_df = 0.8
    max_features = 10000
    minibatch = True
    print("datasets are %(datasets)s" %locals() )

    km = MiniBatchKMeans(n_clusters=num_clusters, init='k-means++', batch_size=1000, n_init=10, max_no_improvement=10, verbose=True)
    km.fit(datasets)
    labels = km.labels_

    transformed = km.transform(X)
    dists = np.zeros(labels.shape)
    for i in range(len(labels)):
        dists[i] = transformed[i, labels[i]]

    clusters = []
    for i in range(num_clusters):
        cluster = []
        ii = np.where(labels==i)[0]
        dd = dists[ii]
        di = np.vstack([dd,ii]).transpose().tolist()
        di.sort()
        for d, j in di:
            cluster.append(datasets[int(j)])
        clusters.append(cluster)

    return clusters

def write_cluster(clusters, outfile):
    f = codecs.open(outfile, 'w')
    for i, values in enumerate(clusters):
        for value in values:
            f.write('%d: %s\n' % (i, value))

clusters = make_cluster(X)
write_cluster(clusters, 'out.txt')
print ( clusters )
