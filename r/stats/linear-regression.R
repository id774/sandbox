# linear-regression.R: Simple linear regression with and without an intercept
#
# Description:
# Fit a linear regression to fixed data with and without an intercept, print
# the coefficients and confidence intervals, and plot the data to image.png.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript linear-regression.R
#
# Requirements:
# - R
#

z <- c( 1, 2, 4, 6, 7, 8, 10, 15 )
x <- c( 0.045, 0.114, 0.215, 0.346, 0.410, 0.520, 0.670, 0.942 )

lm(x~z)
coefficients(summary(lm(x~z)))
summary(lm(x~z-1))
confint(lm(x~z-1))

png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
plot(z, x)
dev.off()
