import numpy as np
from sklearn.cluster import KMeans

features = np.array([
        [  80,  85, 100 ],
        [  96, 100, 100 ],
        [  54,  83,  98 ],
        [  80,  98,  98 ],
        [  90,  92,  91 ],
        [  84,  78,  82 ],
        [  79, 100,  96 ],
        [  88,  92,  92 ],
        [  98,  73,  72 ],
        [  75,  84,  85 ],
        [  92, 100,  96 ],
        [  96,  92,  90 ],
        [  99,  76,  91 ],
        [  75,  82,  88 ],
        [  90,  94,  94 ],
        [  54,  84,  87 ],
        [  92,  89,  62 ],
        [  88,  94,  97 ],
        [  42,  99,  80 ],
        [  70,  98,  70 ],
        [  94,  78,  83 ],
        [  52,  73,  87 ],
        [  94,  88,  72 ],
        [  70,  73,  80 ],
        [  95,  84,  90 ],
        [  95,  88,  84 ],
        [  75,  97,  89 ],
        [  49,  81,  86 ],
        [  83,  72,  80 ],
        [  75,  73,  88 ],
        [  79,  82,  76 ],
        [ 100,  77,  89 ],
        [  88,  63,  79 ],
        [ 100,  50,  86 ],
        [  55,  96,  84 ],
        [  92,  74,  77 ],
        [  97,  50,  73 ],
        ])

kmeans_model = KMeans(n_clusters=3, random_state=10).fit(features)
labels = kmeans_model.labels_

ranks = []
for label, feature in zip(labels, features):
    ranks.append([label, feature, feature.sum()])

ranks.sort(key=lambda x:(-x[2]))

for rank in ranks:
    print (rank)

