png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
library(MASS)
frame()
par(mfrow=c(2, 2))
par(mar=c(2, 2, 1, 2))
par(mgp=c(2, 1, 0))
set.seed(0)
x <- mvrnorm(40, c(0, 1), matrix(c(2, 1.9, 1.9, 2), 2))
d1 <- as.data.frame(cbind(x, 1, 1, 0))
x <- mvrnorm(40, c(4, 0), matrix(c(2, 1.9, 1.9, 2), 2))
d1 <- rbind(d1, as.data.frame(cbind(x, 2, 0, 1)))
x <- mvrnorm(10, c(7, -7), matrix(c(.2, 0, 0, .2), 2))
d2 <- rbind(d1, as.data.frame(cbind(x, 2, 0, 1)))
names(d1) <- c("x1", "x2", "class", "t1", "t2")
names(d2) <- c("x1", "x2", "class", "t1", "t2")
 
doplot <- function(d, fisher) {
	xrange <- c(-4, 8)
	yrange <- c(-8, 4)
	m1 <- c(mean(d$x1[d$class==1]), mean(d$x2[d$class==1]))
	m2 <- c(mean(d$x1[d$class==2]), mean(d$x2[d$class==2]))
	if (fisher) {
		s1 = cov(cbind(d$x1[d$class==1], d$x2[d$class==1])) * (sum(d$class==1) - 1)
		s2 = cov(cbind(d$x1[d$class==2], d$x2[d$class==2])) * (sum(d$class==2) - 1)
		sw = s1 + s2
	} else {
		sw = diag(1, 2)
	}
	w <- solve(sw) %*% (m2 - m1)
	print(w)
	base <- function(x1, x2) {
		(cbind(x1, x2))
	}
	estimate <- function(x1, x2){
		(t(w) %*% t(base(x1, x2)))
	}
	x1 <- seq(-4, 8, .1)
	x2 <- seq(-8, 4, .1)
	y <- outer(x1, x2, estimate)
	plot(d$x1, d$x2, col=d$class, xlim=xrange, ylim=yrange, main=ifelse(fisher, "Fisher's", "max mean diff"))
	contour(x1, x2, y, xlim=xrange, ylim=yrange, add=T)
}

doplot(d1, F)
doplot(d2, F)
doplot(d1, T)
doplot(d2, T)
dev.off()
