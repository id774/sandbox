# -*- coding: utf-8 -*-
# random-walk.py: Random walk with rolling means and autocorrelation
#
# Description:
# Plot a random walk with rolling means and its autocorrelation.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 random-walk.py
#
# Requirements:
# - Python 3
# - NumPy, statsmodels, and Matplotlib
# - pandas before 0.23, which still provides the rolling_mean function
#

import numpy as np
from pandas import *
from statsmodels.tsa import stattools
import matplotlib.pyplot as plt

randn = np.random.randn

ts = Series(randn(1000), index=DateRange('2000/1/1', periods=1000))
ts = ts.cumsum()

ts.plot(style='<--')
rolling_mean(ts, 60).plot(style='--', c='r')
rolling_mean(ts, 180).plot(style='--', c='b')

acf = stattools.acf(np.array(ts), 50)
plt.bar(range(len(acf)), acf, width=0.01)
plt.savefig("image.png")

pcf = stattools.pacf(np.array(ts), 50)
plt.bar(range(len(pcf)), pcf, width=0.01)
plt.show()
plt.savefig("image2.png")
