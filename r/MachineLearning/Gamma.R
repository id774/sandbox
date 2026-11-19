# Gamma.R: Gamma densities for several parameters
#
# Description:
# Plot gamma densities over a grid of shape and rate parameters. The plots are
# written to image.png in the current directory.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript Gamma.R
#
# Requirements:
# - R
#

png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
par(mfrow=c(5, 5))
par(mar=c(2.3, 2.5, 1, 0.1))
par(mgp=c(1.3, .5, 0))
for (a in c(0.5, 1, 1.5, 2, 5)) {
	for (b in c(0.5, 1, 1.5, 2, 5)) {
		curve(dgamma(x, shape=a, rate=b), xlim=c(0, 4), ylim=c(0, 2), ylab="")
		title(paste0("a=", a, " b=", b))
	}
}
dev.off()
