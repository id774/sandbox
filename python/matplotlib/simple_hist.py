# -*- coding:utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt

y = np.array([0.02, 0.12, 0.19, 0.27, 0.42, 0.51, 0.64, 0.84, 0.88, 0.99])
x = [elm for elm in y]

plt.title("Test")
plt.grid(True)
plt.xlabel('X')
plt.ylabel('Y')

plt.hist(x, normed=1, alpha=0.75, align='mid')
plt.show()
plt.savefig("image.png")

