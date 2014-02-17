# -*- coding:utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt

X = np.array([0.02, 0.12, 0.19, 0.27, 0.42, 0.51, 0.64, 0.84, 0.88, 0.99])
t = np.array([0.05, 0.87, 0.94, 0.92, 0.54, -0.11, -0.78, -0.79, -0.89, -0.04])

def phi(x):
    return [1, x, x**2, x**3]

PHI = np.array([phi(x) for x in X])
w = np.linalg.solve(np.dot(PHI.T, PHI), np.dot(PHI.T, t))

print("w の中身は %(w)s" %locals() )

xlist = np.arange(0, 1, 0.01)
ylist = [np.dot(w, phi(x)) for x in xlist]

plt.plot(xlist, ylist)

print("線形回帰の値は \n xlist = %(xlist)s と\n ylist = %(ylist)s" %locals() )

plt.plot(X, t, 'o')
plt.show()
plt.savefig("image.png")
