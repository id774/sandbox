# 引数の2乗を求める．

x <- c(5, 12, 13)
x

# seq_along(ベクトル)により，forループを回す回数を取得する方法．
for (i in seq_along(x)) print(x[i]^2)

# ベクトルをそのまま使う方法．
# forループは，ベクトルxの要素数だけまわる．
# 1回目のループでは，iにはx[1]が代入され，x[1]^2 が出力される．
for (i in x) print(i^2)

# ベクトルがNULLの場合も試してみると，うまく実行される．
x <- c()
for (i in x) print(i^2)

