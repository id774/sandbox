# MultiDimGaussian.R: Two-dimensional Gaussian density
#
# Description:
# Plot a correlated two-dimensional Gaussian density with mvtnorm as a
# perspective plot and a contour plot. The plots are written to image.png in
# the current directory.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript MultiDimGaussian.R
#
# Requirements:
# - R with the mvtnorm package
#

png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
library(mvtnorm)
par(mfrow=c(1, 2))
x1 <- seq(-3, 3, 0.1)
x2 <- seq(-3, 3, 0.1)
p <- outer(x1, x2, Vectorize(function(x1, x2) dmvnorm(c(x1, x2), c(0, 0), matrix(c(1, 0.5, 0.5, 1), 2))))
persp(x1, x2, p, theta=10, zlab="p")
contour(x1, x2, p)
dev.off()
