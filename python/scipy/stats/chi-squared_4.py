# -*- coding:utf-8 -*-
# Test lung cancer contingency tables for men and women with chi2_contingency.

import scipy as sp
import scipy.stats as stats

# Men with and without lung cancer
man = sp.array([
               [1350, 7],
               [1296, 61]
               ])

female = sp.array([
                  [68, 40],
                  [49, 59]
                  ])

def chi_squared_test(data):
    x2, p, dof, expected = stats.chi2_contingency(data)

    print("カイ二乗値は %(x2)s" % locals())
    print("確率は %(p)s" % locals())
    print("自由度は %(dof)s" % locals())
    print(expected)

    if p < 0.05:
        print("有意な差があります")
    else:
        print("有意な差がありません")

    return x2, p, dof, expected

chi_squared_test(man)
chi_squared_test(female)
