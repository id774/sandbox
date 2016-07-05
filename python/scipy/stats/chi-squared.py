# -*- coding:utf-8 -*-

# クリステン・ギルバートの勤務時間中に起きた死者の数をカイ二乗検定
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
