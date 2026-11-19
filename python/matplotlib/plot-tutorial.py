#!/usr/bin/env python
# -*- coding: utf-8 -*-
# plot-tutorial.py: Line, histogram, and scatter panels in one figure
#
# Description:
# Combine line, histogram, and scatter panels in one figure, labelled with a
# Japanese font, and save the plots as image.png through image4.png.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 plot-tutorial.py
#
# Requirements:
# - Python 3
# - NumPy, pandas, and Matplotlib with pylab
# - A Japanese font at /Library/Fonts/Osaka.ttf on macOS or at
#   /usr/share/fonts/truetype/fonts-japanese-gothic.ttf elsewhere
#

import sys
import numpy as np
from pandas import *
from pylab import *
import matplotlib.pyplot as plt
from matplotlib import font_manager
from numpy.random import randn

if sys.platform == "darwin":
    font_path = "/Library/Fonts/Osaka.ttf"
else:
    font_path = "/usr/share/fonts/truetype/fonts-japanese-gothic.ttf"

fontprop = font_manager.FontProperties(fname=font_path)

fig = plt.figure()

ax1 = fig.add_subplot(2, 2, 1)
ax2 = fig.add_subplot(2, 2, 2)
ax3 = fig.add_subplot(2, 2, 3)

plt.show()
plt.savefig("image.png")

ran = randn(50).cumsum()
print(ran)
plt.plot(ran, 'k--')

plt.show()
plt.savefig("image2.png")

ax1.hist(rand(100), bins=20, color='k', alpha=0.3)
ax2.scatter(np.arange(30), np.arange(30) + 3 * randn(30))

plt.show()
plt.savefig("image3.png")

fig, axes = plt.subplots(2, 2, sharex=True, sharey=True)
for i in range(2):
    for j in range(2):
        axes[i, j].hist(randn(500), bins=50, color='k', alpha=0.5)
plt.subplots_adjust(
    left=None, bottom=None, right=None, top=None, wspace=0, hspace=0)

plt.show()
plt.savefig("image4.png")
