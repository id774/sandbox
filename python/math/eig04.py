
# http://qiita.com/kenmatsu4/items/2a8573e3c878fc2da306

import numpy as np
import matplotlib.pyplot as plt

np.random.seed(0)
xmin = -10
xmax = 10
ymin = -10
ymax = 10

# Mean
mu = [2, 2]
# Covariance
cov = [[3, 2.3], [1.8, 3]]

# Draw random numbers from a bivariate normal distribution
x, y = np.random.multivariate_normal(mu, cov, 1000).T

av_x = np.average(x)
av_y = np.average(y)

# Compute the variance covariance matrix from the data
S = np.cov(x, y)
print("S", S)

# Compute the eigenvalues and eigenvectors
la, v = np.linalg.eig(S)

print("la", la)
print("v", v)

# Shift the data so the origin is at its centre
x2 = x - av_x
y2 = y - av_y

# Multiply the shifted data by the matrix of eigenvectors
a1 = np.array([np.dot(v, [x2[i], y2[i]]) for i in range(len(x))])

# Draw the graph
plt.figure(figsize=(8, 13))

# Plot the original data
plt.subplot(211)
plt.xlim(xmin, xmax)
plt.ylim(ymin, ymax)
plt.scatter(x, y, alpha=0.5, zorder=100)
plt.plot([0, 0], [ymin, ymax], "k")
plt.plot([xmin, xmax], [0, 0], "k")

# Plot the data after multiplying by the eigenvector matrix
plt.subplot(212)
plt.xlim(xmin, xmax)
plt.ylim(ymin, ymax)
plt.scatter(a1[:, 0], a1[:, 1], c="r", alpha=0.5, zorder=100)
plt.plot([0, 0], [ymin, ymax], "k")
plt.plot([xmin, xmax], [0, 0], "k")

plt.savefig('image.png')
