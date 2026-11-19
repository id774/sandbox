# significance-level_1.R: Rare outcomes at the 5 percent significance level
#
# Description:
# Plot the binomial distribution of 40 trials with success probability 1/6 and
# find the success count beyond which outcomes occur with at most 5 percent
# probability.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript significance-level_1.R
#
# Requirements:
# - R
#

# 試行回数 N=40
# 成功回数 x=0:40
# 成功確率 p=1/6
# 有意水準 α=0.05

p <- dbinom(x=0:40, size=40, prob=1/6)
plot(x=0:40, p, type="l")

# 有意水準5%でしか起きない確率変数X（＝稀な成功回数）を求める．
# 成功回数11回とは5%の確率，つまり，20回に1回しか起きない稀なこと．
qbinom(0.05, size=40, prob=1/6, lower.tail=FALSE)

abline(v=qbinom(0.05, size=40, prob=1/6, lower.tail=FALSE), col="red")
abline(h=0, col="blue")

