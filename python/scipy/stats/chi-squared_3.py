# -*- coding:utf-8 -*-
# chi-squared_3.py: Independence test of a two by two table
#
# Description:
# Test a two by two contingency table for independence with chi2_contingency.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 chi-squared_3.py
#
# Requirements:
# - Python 3
# - SciPy from a release whose top-level namespace still provides NumPy
#   aliases such as scipy.array
#

import scipy as sp
import scipy.stats as stats

crossed = sp.array([[435, 265],
                    [165, 135]])

x2, p, dof, expected = stats.chi2_contingency(crossed)

print("カイ二乗値は %(x2)s" % locals())
print("確率は %(p)s" % locals())
print("自由度は %(dof)s" % locals())
print(expected)

if p < 0.05:
    print("有意な差があります")
else:
    print("有意な差がありません")
