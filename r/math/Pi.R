# Pi.R: Monte Carlo estimate of pi
#
# Description:
# Estimate pi from ten million uniform random points in the unit square.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript Pi.R
#
# Requirements:
# - R
#

s <- 10000000
x <- runif(s)
y <- runif(s)
sum(x^2+y^2 <= 1)*4/s
