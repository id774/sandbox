png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
library(mvtnorm)
frame()
set.seed(0)
par(mfcol=c(3, 6))
par(mar=c(2, 2, 1, 0.1))
par(mgp=c(1, 0.2, 0))
xrange <- c(-1, 1)
yrange <- c(-1, 1)
x1 <- seq(xrange[1], xrange[2], .05)
x2 <- seq(yrange[1], yrange[2], .05)
colors <- rainbow(450)[256:1]
M <- 2
N <- 6
 
base <- function(m, x) {
	r <- x^m						#多項式基底の場合
#	r <- exp(-(x-(m-1)/(M-2))^2/(2*0.2^2))	#ガウス基底の場合
	r[m == 0]<-1					# w0をバイアス項とするためφ0=1
	r
}
makePhi<-function(M, x) {
	A <- matrix(nrow=length(x), ncol=M)
	for (i in 1:length(x)) {
		for (j in 0:(M-1)) {
			A[i, 1+j] <- base(j, x[i])
		}
	}
	A
}
x <- runif(N, -1, 1)
phi <- makePhi(M, x)
wTrue <- c(-0.3, 0.5)
y <- rnorm(N, t(wTrue) %*% t(phi), 0.2)

alpha <- 0.1
beta <- (1 / 0.2) ^ 2
s0inv <- alpha * diag(1, M)
m0 <- rep(0, M)
for (n in 1:nrow(phi)) {
	# current prior probability distribution
	cat("s");print(solve(s0inv))
	cat("m");print(m0)
	prior <- function(x1, x2) {
		dmvnorm(c(x1, x2), m0, solve(s0inv))
	}
	par(cex=0.5)
	image(x1, x2, outer(x1,x2,Vectorize(prior)), xlim=xrange, ylim=yrange, col=colors, xlab="w0", ylab="w1")
	title("prior")

	# take nth sample
	phin <- t(phi[n,])
	yn <- y[n]

	# derive the posterior
	sninv <- s0inv + beta * t(phin) %*% phin
	mn <- solve(sninv) %*% (s0inv %*% m0 + beta * t(phin) %*% yn)

	# use the posterior as the next prior
	s0inv <- sninv
	m0 <- mn

	# plot the sample, bayes regression, and the likelihood on its sample
	plot(phi[1:n,2], y[1:n], xlim=xrange, ylim=yrange, xlab="x", ylab="y")
	title("sample")
	for (j in 1:100) {
		w <- rmvnorm(1, m0, solve(s0inv))
		estimate<-function(x){
			(w %*% t(makePhi(M, x)))  # (w[1]+w[2]*base(1,x)+w[3]*base(2,x)...)
		}
		par(new=T)
		curve(estimate, type="l", xlim=xrange, ylim=yrange, col=rgb(1, 0, 0, alpha=0.1), xlab="", ylab="", axes=F)
	}
	par(new=T)
	plot(phi[1:n,2], y[1:n], xlim=xrange, ylim=yrange, xlab="", ylab="", axes=F)
	likelihood <- function(x1, x2) {
		dnorm(yn, phin %*% c(x1, x2), sqrt(1 / beta))
	}
	image(x1, x2, outer(x1,x2,Vectorize(likelihood)), xlim=xrange, ylim=yrange, col=colors, xlab="w0", ylab="w1")
	title("likelihood")
}
dev.off()
