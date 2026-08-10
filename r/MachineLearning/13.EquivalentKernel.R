png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
frame()
set.seed(0)
par(mfrow=c(2, 2))
par(mar=c(2, 2, 1, 0.1))
par(mgp=c(1, 0.2, 0))
xrange <- c(-1.0, 1.0)
yrange <- c(-1.5, 1.5)
x1 <- seq(xrange[1], xrange[2], .02)
x2 <- seq(yrange[1], yrange[2], .02)
colors <- rainbow(450)[256:1]
M <- 10
N <- 6

base <- function(m, x) {
#	r <- x^m										#多項式基底の場合
	r <- exp(-(x-(2*(m-1)/(M-2)-1))^2/(2*0.2^2))	#ガウス基底の場合
	r[m == 0]<-1									# w0をバイアス項とするためφ0=1
	r
}
for (m in (1:M)) {
	basem <- function(x) { base(m, x) }
	par(new=(m>1))
	curve(basem, xlim=xrange, ylim=yrange, ylab="phi(x)")
}
title("basis func.")
 
makePhi<-function(M, x) {
	A <- matrix(nrow=length(x), ncol=M)
	for (i in 1:length(x)) {
		for (j in 0:(M-1)) {
			A[i, 1+j] <- base(j, x[i])
		}
	}
	A
}
x <- seq(-1, 1, 2 / (N - 1))
y <- rnorm(length(x), sin(2 * pi * x), 0.2)

alpha <- 0.1
beta <- (1 / 0.2) ^ 2

# prior probability distribution
s0inv <- alpha * diag(1, M)
m0 <- rep(0, M)
cat("s0");print(solve(s0inv))
cat("m0");print(m0)

# derive the posterior
phi <- makePhi(M, x)
sninv <- s0inv + beta * t(phi) %*% phi
sn <- solve(sninv)
mn <- sn %*% (s0inv %*% m0 + beta * t(phi) %*% y)
cat("sn");print(sn)
cat("mn");print(mn)

kernel <- function(x, xd) {
	phix <- t(makePhi(M, x))
	phixd <- t(makePhi(M, xd))
	beta * t(phix) %*% sn %*% phixd
}
image(x1, x2, outer(x1, x2, Vectorize(kernel)), xlim=xrange, ylim=xrange, col=colors, xlab="x", ylab="x'")
title("k(x,x')")

plot(x, y, type="n", xlim=xrange, ylim=yrange)
for (n in 1:N) {
	col = rainbow(N)[n]
	kernelN <- function(xx) {
		kernel(xx, x[n])
	}
	par(new=T)
	curve(kernelN, xlim=xrange, ylim=yrange, xlab="", ylab="", axes=F, col=col)
}
legend("bottomright", legend=paste("x'=", round(x,1)), col=rainbow(N), lty=1, cex=1, y.intersp=1)
title("k(x,x')")

plot(x, y, type="n", xlim=xrange, ylim=yrange)
estimate <- function(xx) {
	kernel(xx, x) %*% y
}
par(new=T)
curve(estimate, xlim=xrange, ylim=yrange, xlab="", ylab="", axes=F, col=gray(0.5))
for (n in 1:N) {
	col = rainbow(N)[n]
	par(new=T)
	plot(x[n], y[n], pch=16, xlim=xrange, ylim=yrange, xlab="", ylab="", axes=F, col=col)
	kernelT <- function(xx) {
		kernel(xx, x[n]) * y[n]
	}
	par(new=T)
	curve(kernelT, xlim=xrange, ylim=yrange, xlab="", ylab="", axes=F, col=col)
}
title("tn, k(x,xn)tn, y(x)")
dev.off()
