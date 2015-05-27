
# http://qiita.com/kenmatsu4/items/2a8573e3c878fc2da306

import numpy as np
import matplotlib.pyplot as plt

plt.figure(figsize=(10, 10))
n = 10
xmin = -5
xmax = 35
ymin = -20
ymax = 10

A = [[2, 1],
     [-0.5, -1.5]]
for i in range(n):
    for j in range(n):
        x = j
        y = i

        a = np.dot(A, [x, y])

        loc_adjust = .2  # 表示位置の調整
        plt.text(x - loc_adjust, y - loc_adjust, "%d" %
                 (i * n + j), color="blue")
        plt.text(a[0] - loc_adjust, a[1] - loc_adjust, "%d" %
                 (i * n + j), color="red")

        plt.plot([xmin, xmax], [0, 0], "k", linewidth=1)
        plt.plot([0, 0], [ymin, ymax], "k", linewidth=1)
        plt.xlim(xmin, xmax)
        plt.ylim(ymin, ymax)
plt.savefig('image.png')
