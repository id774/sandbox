# -*- coding:utf-8 -*-

import numpy as np
import scipy.stats

s = 55
f = 45
e = 50

observed = np.array([s,f])
expected = np.array([e,e])

# Chi-squared test
x2, p = scipy.stats.chisquare(observed, expected)

print("カイ二乗値は %(x2)s" %locals() )
print("確率は %(p)s" %locals() )

if p > 0.05:
    print("有意です")
else:
    print("有意ではありません")

