# sin_05.R: Vectorized and element-wise conditionals
#
# Description:
# Compare a vectorized condition, a function applied with sapply, and ifelse
# on random values.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript sin_05.R
#
# Requirements:
# - R
#

sin_0.5 <- function (x) sin(x>0.5)

sin_0.5(runif(10))

sinv_0.5 <- function (x) {
    temp <- function(x) if (x<0) return(2) else return(3)
        sapply(x, temp) }

sinv_0.5(runif(10)-0.5)

ifelse(runif(10) - 0.5 < 0, 2, 3)
