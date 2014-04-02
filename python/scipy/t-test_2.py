import numpy as np
import scipy as sp
from scipy import stats

rvs1 = stats.norm.rvs(loc=1273,scale=29.5,size=10)
rvs2 = stats.norm.rvs(loc=1286,scale=35.4,size=10)

print( rvs1 )
print( rvs2 )
t, p = stats.ttest_rel(rvs1, rvs2)

print( "t 値は %(t)s" %locals() )
print( "確率は %(p)s" %locals() )

if p < 0.05:
    print("有意な差があります")
else:
    print("有意な差がありません")

