
import numpy as np
import matplotlib.pyplot as mpl
from scipy.spatial import distance
from sklearn.cluster import DBSCAN

c1 = np.random.randn(100, 2) + 5
c2 = np.random.randn(50, 2)

u1 = np.random.uniform(low=-10, high=10, size=100)
u2 = np.random.uniform(low=-10, high=10, size=100)
c3 = np.column_stack([u1, u2])

print("u1", u1)
print("u2", u2)
print("c3", c3)

data = np.vstack([c1, c2, c3])

db = DBSCAN().fit(data)
labels = db.labels_

dbc1 = data[labels == 0]
dbc2 = data[labels == 1]
noise = data[labels == -1]

print("dbc1", dbc1)
print("dbc2", dbc2)
print("noise", noise)

x1, x2 = -12, 12
y1, y2 = -12, 12
fig = mpl.figure()
fig.subplots_adjust(hspace=0.1, wspace=0.1)
ax1 = fig.add_subplot(121, aspect='equal')
ax1.scatter(c1[:, 0], c1[:, 1], lw=0.5, color='#00CC00')
ax1.scatter(c2[:, 0], c2[:, 1], lw=0.5, color='#028E9B')
ax1.scatter(c3[:, 0], c3[:, 1], lw=0.5, color='#FF7800')
ax1.xaxis.set_visible(False)
ax1.yaxis.set_visible(False)
ax1.set_xlim(x1, x2)
ax1.set_ylim(y1, y2)
ax1.text(-11, 10, 'Original')
ax2 = fig.add_subplot(122, aspect='equal')
ax2.scatter(dbc1[:, 0], dbc1[:, 1], lw=0.5, color='#00CC00')
ax2.scatter(dbc2[:, 0], dbc2[:, 1], lw=0.5, color='#028E9B')
ax2.scatter(noise[:, 0], noise[:, 1], lw=0.5, color='#FF7800')
ax2.xaxis.set_visible(False)
ax2.yaxis.set_visible(False)
ax2.set_xlim(x1, x2)
ax2.set_ylim(y1, y2)
ax2.text(-11, 10, 'DBSCAN identified')
fig.savefig('image.png', bbox_inches='tight')
