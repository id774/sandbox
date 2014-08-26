# -*- coding:utf-8 -*-

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
