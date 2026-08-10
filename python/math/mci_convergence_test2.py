# Test Monte Carlo integration convergence on a heavy tailed distribution.

import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import cauchy, norm
import scipy.integrate

# http://aidiary.hatenablog.com/entry/20140830/1409398547

# Convergence test for Monte Carlo integration
# Exercise 3.1

N = 1000
x = 4
Inf = float("inf")

# Integrate with scipy.integrate
h1 = lambda t: t * norm(loc=x).pdf(t) * cauchy.pdf(t)
h2 = lambda t: norm(loc=x).pdf(t) * cauchy.pdf(t)
num = scipy.integrate.quad(h1, -Inf, Inf)[0]
den = scipy.integrate.quad(h2, -Inf, Inf)[0]
I = num / den
print("scipy.integrate:", I)

# (1) Convergence test sampling from the Cauchy distribution
# Assume the numerator and denominator use the same samples
theta = cauchy.rvs(size=N)
num = theta * norm(loc=x).pdf(theta)
den = norm(loc=x).pdf(theta)

# Drop the samples that put zero in the denominator
num = num[den != 0]
den = den[den != 0]
Ndash = len(num)

y = num / den
estint = (np.cumsum(num) / np.arange(1, Ndash + 1)) / \
    (np.cumsum(den) / np.arange(1, Ndash + 1))
esterr = np.sqrt(np.cumsum((y - estint) ** 2)) / np.arange(1, Ndash + 1)

plt.subplot(2, 1, 1)
plt.plot(estint, color='red', linewidth=2)
plt.plot(estint + 2 * esterr, color='pink', linewidth=1)
plt.plot(estint - 2 * esterr, color='pink', linewidth=1)
plt.title('sampling from cauchy distribution')
plt.ylim((0, 6))

# (2) Convergence test sampling from the normal distribution
theta = norm(loc=x).rvs(size=N)
num = theta * cauchy.pdf(theta)
den = cauchy.pdf(theta)

num = num[den != 0]
den = den[den != 0]
Ndash = len(num)

y = num / den
estint = (np.cumsum(num) / np.arange(1, Ndash + 1)) / \
    (np.cumsum(den) / np.arange(1, Ndash + 1))
esterr = np.sqrt(np.cumsum((y - estint) ** 2)) / np.arange(1, Ndash + 1)

plt.subplot(2, 1, 2)
plt.plot(estint, color='blue', linewidth=2)
plt.plot(estint + 2 * esterr, color='cyan', linewidth=1)
plt.plot(estint - 2 * esterr, color='cyan', linewidth=1)
plt.title('sampling from normal distribution')
plt.ylim((0, 6))

plt.tight_layout()
plt.show()
plt.savefig('2.png')
