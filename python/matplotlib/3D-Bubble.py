# 3D-Bubble.py: Three-dimensional scatter of random groups
#
# Description:
# Scatter random points in three dimensions, one colour per group.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 3D-Bubble.py
#
# Requirements:
# - Python 3
# - NumPy and Matplotlib with mpl_toolkits.mplot3d
#

from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import matplotlib.pyplot as plt

fig = plt.figure()
ax = fig.gca(projection='3d')
colors = ('r', 'g', 'b', 'k')
for c in colors:
    x = np.random.sample(30)
    y = np.random.sample(30)
    ax.scatter(x, y, 0, zdir='y', c=c)

ax.legend()
ax.set_xlim3d(0, 1)
ax.set_ylim3d(0, 1)
ax.set_zlim3d(0, 1)

plt.show()
plt.savefig("image.png")
