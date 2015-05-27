
# http://qiita.com/kenmatsu4/items/2a8573e3c878fc2da306

import matplotlib.pyplot as plt
import numpy as np
# from matplotlib import animation as ani

plt.figure(figsize=(8, 8))
n = 20

A = [[2, 1],
     [-0.5, -1.5]]
x = [1, 1]

a = np.dot(A, x)   # ここでAxを計算している

plt.plot([0, x[0]], [0, x[1]], "b", zorder=100)
plt.plot([0, a[0]], [0, a[1]], "r", zorder=100)

plt.plot([-15, 50], [0, 0], "k", linewidth=1)
plt.plot([0, 0], [-40, 40], "k", linewidth=1)
plt.xlim(-1, 4)
plt.ylim(-3, 2)
plt.savefig('image.png')
