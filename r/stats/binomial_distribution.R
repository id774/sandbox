# binomial_distribution.R: Binomial distribution of twelve dice rolls
#
# Description:
# Compute the expected value and draw a bar plot of the binomial distribution
# with 12 trials and success probability 1/6.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript binomial_distribution.R
#
# Requirements:
# - R
#

# 試行回数 N=12
# 成功確率 p=1/6

x <- 0:12
p <- dbinom(0:12, size=12, prob=1/6)

sum(x * p)

barplot(p)
axis(side=1, at=barplot(p), labels=x)

