# -*- coding:utf-8 -*_

import matplotlib.pyplot as plt
import numpy as np
import math

def poisson(lambd):
    def f(x):
        return float(lambd ** x) * np.exp(-lambd) / math.factorial(x)
    return f

N = 8
L = []
score_mean = 0.8

f = poisson(score_mean)
L.append([f(k) for k in range(N + 1)])

for prob in L:
   plt.plot(range(N + 1), prob, 'r')

ax = plt.axes()

ax.set_xlim(0, N)
ax.set_ylim(-0.01, 0.5)

plt.title('Soccer Score')
plt.xlabel('Score')
plt.ylabel('Probability')
plt.grid(True)

plt.show()
plt.savefig("image.png")
