# 24.RobbinsMonro.R: Robbins-Monro estimate of a mean
#
# Description:
# Estimate the mean of 40 normal samples sequentially with the Robbins-Monro
# procedure and plot the estimates. The plots are written to image.png in the
# current directory.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript 24.RobbinsMonro.R
#
# Requirements:
# - R
#

png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
frame()
set.seed(0)
par(mfrow=c(1, 1))
par(mar=c(2.3, 2.5, 1, 0.1))
par(mgp=c(1.3, .5, 0))
N <- 40
U <- 150
x <- rnorm(N, U, 10)
uml <- 0
umls <- numeric()
d <- data.frame(observation=-1, x=NA, new=F)
for (n in 1:N) {
	uml <- uml + (1 / n) * (x[n] - uml)
	umls <- c(umls, uml)
	if (n > 1) {
		previous <- d[d$observation == n - 1, ]
		previous$observation = n
		previous$new = F
		d <- rbind(d, previous)
	}
	d <- rbind(d, c(n, x[n], T))
}
d <- d[-1, ]
plot(umls, type="o", col=2, xlim=c(1,N), ylim=c(min(x), max(x)), xlab="", ylab="")
par(new=T)
plot(d$observation, d$x, pch=19, cex=ifelse(d$new, 1, 0.1), xlim=c(1,N), ylim=c(min(x), max(x)))
abline(h=U)
dev.off()
