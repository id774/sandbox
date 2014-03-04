# -*- coding:utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt

t = np.array([24, 27, 29, 34, 42, 43, 51])
X = np.array([236, 330, 375, 392, 460, 525, 578])

def phi(x):
    return [1, x, x**2, x**3]

def f(w, x):
    return np.dot(w, phi(x))

PHI = np.array([phi(x) for x in X])
w = np.linalg.solve(np.dot(PHI.T, PHI), np.dot(PHI.T, t))

plt.xlim(200, 600)
plt.ylim(20, 55)
plt.plot(X, t, 'o', color="blue")
plt.show()
plt.savefig("image.png")

print("w の中身は %(w)s" %locals() )
print("PHI の中身は %(PHI)s" %locals() )

ave = np.average(X)
print("X の平均は %(ave)s" %locals() )

var = np.var(X)
print("X の分散は %(var)s" %locals() )

std = np.std(X)
print("X の標準偏差は %(std)s" %locals() )

xlist = np.arange(200, 600, 10)
ylist = [f(w, x) for x in xlist]

plt.plot(xlist, ylist, color="blue")
plt.xlim(200, 600)
plt.ylim(20, 55)
plt.plot(X, t, 'o', color="green")
plt.show()
plt.savefig("image2.png")

