# random-normal3.py: Gaussian fit of a small data set with curve_fit
#
# Description:
# Fit a Gaussian to a small hand written data set with curve_fit.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 random-normal3.py
#
# Requirements:
# - Python 3
# - SciPy and Matplotlib with pylab
#

import pylab as plb
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit
from scipy import asarray as ar, exp

x = ar(range(10))
y = ar([0, 1, 2, 3, 4, 5, 4, 3, 2, 1])

n = len(x)
mean = sum(x * y) / n
sigma = sum(y * (x - mean) ** 2) / n

def gaus(x, a, x0, sigma):
    return a * exp(-(x - x0) ** 2 / (2 * sigma ** 2))

popt, pcov = curve_fit(gaus, x, y, p0=[1, mean, sigma])

plt.plot(x, y, 'b+:', label='data')
plt.plot(x, gaus(x, *popt), 'ro:', label='fit')
plt.legend()
plt.title('Fig. 1 - Fit for Time Constant')
plt.xlabel('Time (s)')
plt.ylabel('Voltage (V)')
plt.show()
plt.savefig("image.png")
