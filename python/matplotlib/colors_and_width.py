# -*- coding:utf-8 -*-
# colors_and_width.py: Cosine and sine with explicit colors and line widths
#
# Description:
# Plot cosine and sine with explicit colours, line widths, and axis limits.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 colors_and_width.py
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
plt.xticks(np.linspace(-4, 4, 9, endpoint=True))
plt.ylim(-1.0, 1.0)
plt.yticks(np.linspace(-1, 1, 5, endpoint=True))

plt.plot(X, C)
plt.plot(X, S)
plt.show()
plt.savefig("image.png")
