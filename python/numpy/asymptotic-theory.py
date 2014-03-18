#!/usr/bin/env python

import matplotlib.pyplot as plt
import numpy as np
import itertools as it

def coin_toss(lim):
    _randomized = np.random.randint(2, size=lim)
    _succeed = [i for i in _randomized if i == 1]
    return len(_succeed)

X = []
Y = []
lim = 100

for i in range(lim):
    X.append(i)
    Y.append(coin_toss(lim = 40000))

print (X)
print (Y)

plt.xlim(0, lim)
plt.ylim(19400, 21600)
plt.xlabel('X')
plt.ylabel('Y')
plt.plot(X, Y, 'o', color="blue")
plt.show()
plt.savefig("image.png")
