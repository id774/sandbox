from scipy import stats

X = [68,75,80,71,73,79,69,65]
Y = [86,83,76,81,75,82,87,75]

print(X)
print(Y)

t, p = stats.ttest_rel(X, Y)

print( "t 値は %(t)s" %locals() )
print( "確率は %(p)s" %locals() )

if p < 0.05:
    print("有意な差があります")
else:
    print("有意な差がありません")

