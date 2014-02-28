import numpy as np
from sklearn.cluster import KMeans

import sys, os
import codecs
import numpy as np

from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.cluster import KMeans, MiniBatchKMeans
from sklearn.decomposition import TruncatedSVD
from sklearn.preprocessing import Normalizer
from sklearn import datasets
from sklearn import metrics

dataset = datasets.load_iris()
x = dataset.data

kmeans_model = KMeans(n_clusters=3, random_state=1).fit(x)
labels = kmeans_model.labels_
print ( metrics.silhouette_score(x, labels, metric='euclidean') )

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

    transformed = km.transform(x)
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

clusters = make_cluster(x)
write_cluster(clusters, 'out.txt')
print ( clusters )
