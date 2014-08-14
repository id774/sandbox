# -*- coding: utf-8 -*-

import chisquare
import scipy as sp

array = sp.array([[435, 165],
                  [265, 135]])
ch2, p = chisquare.chisquare_test(array)

print("カイ二乗値は %(ch2)s" % locals())
print("確率は %(p)s" % locals())

if p < 0.05:
    print("有意な差があります")
else:
    print("有意な差がありません")
