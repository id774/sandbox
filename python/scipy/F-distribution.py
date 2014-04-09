# -*- coding:utf-8 -*-

import numpy as np
from scipy.stats import f
import matplotlib.pyplot as plt

def draw_graph(dfn, dfd):
    rv = f(dfn, dfd)
    x = np.linspace(0, np.minimum(rv.dist.b, 3))
    plt.plot(x, rv.pdf(x))

draw_graph(1, 1)
draw_graph(2, 1)
draw_graph(5, 2)

plt.grid(True)
plt.show()
plt.savefig('image.png')
