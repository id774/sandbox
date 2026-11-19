# -*- coding:utf-8 -*-
# chi-squared.py: Chi-squared test of deaths during Kristen Gilbert's shifts
#
# Description:
# Run a chi-squared test on the contingency table, given in the comment below,
# of deaths that occurred during Kristen Gilbert's shifts.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 chi-squared.py
#
# Requirements:
# - Python 3
# - SciPy from a release whose top-level namespace still provides NumPy
#   aliases such as scipy.array
#

# Chi-squared test on the deaths that occurred during Kristen Gilbert's shifts
#
# https://en.wikipedia.org/wiki/Kristen_Gilbert
# http://www.stat.ucla.edu/~nchristo/statistics13/article.pdf
#
#                    DEATH ON SHIFT?
# GILBERT PRESENT    YES      NO      TOTAL
# YES                 40      217       257
# NO                  34     1350      1384
# TOTAL               74     1567      1641

import scipy as sp
import scipy.stats as stats

crossed = sp.array([[40, 217],
                    [34, 1350]])

x2, p, dof, expected = stats.chi2_contingency(crossed)

print("カイ二乗値は %(x2)s" % locals())
print("確率は %(p)s" % locals())
print("自由度は %(dof)s" % locals())
print(expected)

if p < 0.01:
    print("有意な差があります")
else:
    print("有意な差がありません")
