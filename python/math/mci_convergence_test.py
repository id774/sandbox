# Test the convergence of Monte Carlo integration against a known integral.

import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import uniform
import scipy.integrate

# http://aidiary.hatenablog.com/entry/20140830/1409398547

# Convergence test for Monte Carlo integration
# The case of example 3.3

N = 10000

a, b = 0, 1
h = lambda x: (np.cos(50 * x) + np.sin(20 * x)) ** 2

# Compute the integral with scipy.integrate
I = scipy.integrate.quad(h, a, b)[0]
print("scipy.integrate:", I)

# Convergence test for Monte Carlo integration
x = h(uniform(loc=a, scale=b - a).rvs(size=N))

# Compute every estimate at once, from h_1 with one sample to h_N with N
estint = np.cumsum(x) / np.arange(1, N + 1)

# Compute every standard deviation at once, from sqrt(v_1) to sqrt(v_N)
esterr = np.sqrt(np.cumsum((x - estint) ** 2)) / np.arange(1, N + 1)

plt.plot(estint, color='red', linewidth=2)
plt.plot(estint + 2 * esterr, color='gray')
plt.plot(estint - 2 * esterr, color='gray')
plt.ylim((0, 2))
plt.show()
plt.savefig('1.png')
