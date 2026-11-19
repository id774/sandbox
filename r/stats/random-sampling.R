# random-sampling.R: Sample means and deviations of random draws
#
# Description:
# Draw 100 values without replacement from two simulated populations of 1000
# and print the sample means and standard deviations.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript random-sampling.R
#
# Requirements:
# - R
#

# 生活指導が厳しい医師の外来に通う1000人から100人を無作為抽出し，標本平均と標本標準偏差を求める．
mean(sample(x=rnorm(n=1000,mean=6.5, sd=1), size=100, replace=FALSE))
sd(sample(x=rnorm(n=1000,mean=6.5, sd=1), size=100, replace=FALSE))

# 生活指導の厳しくない医師の外来に通う1000人から100人を無作為抽出し，標本平均と標本標準偏差を求める．
mean(sample(x=rnorm(n=1000,mean=7.5, sd=1.5), size=100, replace=FALSE))
sd(sample(x=rnorm(n=1000,mean=7.5, sd=1.5), size=100, replace=FALSE))

