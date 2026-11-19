# poisson.py: Poisson mass functions across rate parameters
#
# Description:
# Plot Poisson mass functions across a range of rate parameters.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 poisson.py
#
# Requirements:
# - Python 3
# - Matplotlib with pylab
# - SciPy before 1.3, which still provides scipy.misc.factorial
#

from pylab import *
import scipy.misc

def poisson_pmf_gen(mu):
    e_mu = e ** mu
    return lambda x: mu ** x / (e_mu * scipy.misc.factorial(x))

for mu in arange(1, 11):
    pmf = poisson_pmf_gen(mu)

    axis([0, 15, 0, pmf(mu) + 0.05])
    xlabel('x')
    ylabel('p(x)')
    title("Poisson distribution (mu = %d)" % mu)

    x = arange(0, 15)
    bar(x, pmf(x), 0.8, color="gray")

    savefig("poisson_naive_%02d" % mu)
    clf()
