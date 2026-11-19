# loop.R: Two ways to loop over a vector
#
# Description:
# Print the squares of a vector's elements by looping over seq_along indexes
# and by looping over the elements directly.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript loop.R
#
# Requirements:
# - R
#

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

