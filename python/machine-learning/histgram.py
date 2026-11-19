# -*- coding:utf-8 -*-
# histgram.py: Histogram of a normal sample with its density curve
#
# Description:
# Plot a histogram of a normal sample against its density curve.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 histgram.py
#
# Requirements:
# - Python 3
# - NumPy
# - Matplotlib before 3.1, which still provides matplotlib.mlab.normpdf
#

import matplotlib.mlab as mlab
import matplotlib.pyplot as plt
import numpy as np

sample = 1000
mu, sigma = 170, 5
data = np.random.normal(mu, sigma, sample)

print("出力するデータは %(data)s" % locals())

n, bins, patches = plt.hist(data, normed=1, alpha=0.75, align='mid')
y = mlab.normpdf(bins, mu, sigma)
l = plt.plot(bins, y, 'r-', linewidth=1)

plt.title(
    r'$\mathrm{Histgram\ of\ Height:}\ \mu=%d,\ \sigma=%d$' % (mu, sigma))
plt.xlabel('Height')
plt.ylabel('Probability')
plt.grid(True)

plt.show()
plt.savefig("image.png")
