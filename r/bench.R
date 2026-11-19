# bench.R: Small matrix operations for benchmarking
#
# Description:
# Multiply, invert, and decompose a random 10 by 10 matrix with solve and svd.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript bench.R
#
# Requirements:
# - R
#

n = 10
A = matrix(rnorm(n*n),n,n) 
A %*% A
solve(A)
svd(A)
