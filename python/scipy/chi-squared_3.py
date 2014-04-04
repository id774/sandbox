# -*- coding:utf-8 -*-

import scipy as sp
import scipy.stats

crossed = sp.array([[320, 100],
                    [180,  85]])

x2, p, dof, expected = sp.stats.chi2_contingency(crossed)

print("カイ二乗値は %(x2)s" %locals() )
print("確率は %(p)s" %locals() )

if p < 0.05:
    print("有意な差があります")
else:
    print("有意な差がありません")

