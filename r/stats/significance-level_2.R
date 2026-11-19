# significance-level_2.R: Rare outcomes at the 10 percent significance level
#
# Description:
# Plot the binomial distribution of 40 trials with success probability 1/6 and
# mark the upper 10 percent quantile.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript significance-level_2.R
#
# Requirements:
# - R
#

# 施行回数 N=40
# 成功回数 x=0:N
# 成功確率 p=1/6
# 有意水準 α=0.1

p <- dbinom(x=0:40, size=40, prob=1/6)
plot(x=0:40, p, type="l")
qbinom(0.1, size=40, prob=1/6, lower.tail=FALSE)

abline(v=qbinom(0.1, size=40, prob=1/6, lower.tail=FALSE), col="red")

