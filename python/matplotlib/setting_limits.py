# -*- coding:utf-8 -*-
# setting_limits.py: Cosine and sine with explicit limits and ticks
#
# Description:
# Plot cosine and sine with explicit axis limits and tick positions.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 setting_limits.py
#
# Requirements:
# - Python 3
# - NumPy and Matplotlib
#

import numpy as np
import matplotlib.pyplot as plt

X = np.linspace(-np.pi, np.pi, 256, endpoint=True)
C, S = np.cos(X), np.sin(X)

plt.figure(figsize=(8, 6), dpi=80)
plt.figure(figsize=(10, 6), dpi=80)
plt.plot(X, C, color="blue", linewidth=2.5, linestyle="-")
plt.plot(X, S, color="red", linewidth=2.5, linestyle="-")

plt.xlim(-4.0, 4.0)
plt.xticks([-np.pi, -np.pi / 2, 0, np.pi / 2, np.pi])
plt.yticks([-1, 0, +1])
plt.yticks(np.linspace(-1, 1, 5, endpoint=True))

plt.plot(X, C)
plt.plot(X, S)
plt.show()
plt.savefig("image.png")
