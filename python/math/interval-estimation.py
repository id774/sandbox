# Estimate a confidence interval for the mean of a normal sample.

import numpy as np

# Prepare 500 samples drawn from a normal distribution
data = np.random.normal(loc=100, scale=25, size=500)

# Compute the mean
mu = np.mean(data)
print("mu", mu)

# Compute the variance
s2 = np.var(data, ddof=1)
print("s2", s2)

# 90% confidence interval
from scipy.stats import norm
rv = norm()
z = rv.ppf(0.995)
print("z", z)

# 100(1-sigma)% confidence interval
r = np.array([-z, z]) * np.sqrt(25 / 500)
print("mu+r", mu + r)
