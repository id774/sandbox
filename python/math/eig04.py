
# http://qiita.com/kenmatsu4/items/2a8573e3c878fc2da306

import numpy as np
import matplotlib.pyplot as plt

np.random.seed(0)
xmin = -10
xmax = 10
ymin = -10
ymax = 10

# 平均
mu = [2, 2]
# 共分散
cov = [[3, 2.3], [1.8, 3]]

# 2変量正規分布の乱数生成
x, y = np.random.multivariate_normal(mu, cov, 1000).T

av_x = np.average(x)
av_y = np.average(y)

# 分散共分散行列をデータより算出
S = np.cov(x, y)
print("S", S)

# 固有値、固有ベクトルを算出
la, v = np.linalg.eig(S)

print("la", la)
print("v", v)

# 原点が中心になるようスライドさせる
x2 = x - av_x
y2 = y - av_y

# 原点をスライドしたデータに、固有ベクトルを並べて作った行列をかける
a1 = np.array([np.dot(v, [x2[i], y2[i]]) for i in range(len(x))])

# グラフの描画
plt.figure(figsize=(8, 13))

# 元データのプロット
plt.subplot(211)
plt.xlim(xmin, xmax)
plt.ylim(ymin, ymax)
plt.scatter(x, y, alpha=0.5, zorder=100)
plt.plot([0, 0], [ymin, ymax], "k")
plt.plot([xmin, xmax], [0, 0], "k")

# 固有ベクトルを並べて作った行列をかけたデータのプロット
plt.subplot(212)
plt.xlim(xmin, xmax)
plt.ylim(ymin, ymax)
plt.scatter(a1[:, 0], a1[:, 1], c="r", alpha=0.5, zorder=100)
plt.plot([0, 0], [ymin, ymax], "k")
plt.plot([xmin, xmax], [0, 0], "k")

plt.savefig('image.png')
