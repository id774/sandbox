import scipy as sp
from scipy import stats

X = sp.array([90, 75, 75, 75, 80, 65, 75, 80])
Y  = sp.array([95, 80, 80, 80, 75, 75, 80, 85])

t, p = stats.ttest_rel(X, Y)

print( "t 値は %(t)s" %locals() )
print( "確率は %(p)s" %locals() )

if p < 0.05:
    print("有意な差があります")
else:
    print("有意な差がありません")

