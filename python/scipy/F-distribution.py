# -*- coding:utf-8 -*-
# F-distribution.py: F distribution densities
#
# Description:
# Plot F distribution densities for several pairs of degrees of freedom.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 F-distribution.py
#
# Requirements:
# - Python 3
# - NumPy, SciPy, and Matplotlib
#

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
