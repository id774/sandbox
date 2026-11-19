# simple_clustering.py: KMeans clustering of CSV features ranked by row total
#
# Description:
# Cluster CSV features with KMeans and rank them by row total.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 simple_clustering.py
#
# Requirements:
# - Python 3
# - NumPy and scikit-learn
# - data.csv in the current directory
#

import numpy as np
from sklearn.cluster import KMeans

features = np.genfromtxt('data.csv', delimiter=',')

kmeans_model = KMeans(n_clusters=3, random_state=10).fit(features)
labels = kmeans_model.labels_

ranks = []
for label, feature in zip(labels, features):
    ranks.append([label, feature, feature.sum()])

ranks.sort(key=lambda x: (-x[2]))

for rank in ranks:
    print(rank)
