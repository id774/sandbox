import numpy as np
from sklearn.cluster import KMeans

features = np.genfromtxt('data.csv', delimiter=',')

kmeans_model = KMeans(n_clusters=3, random_state=10).fit(features)
labels = kmeans_model.labels_

ranks = []
for label, feature in zip(labels, features):
    ranks.append([label, feature, feature.sum()])

ranks.sort(key=lambda x:(-x[2]))

for rank in ranks:
    print(rank)

