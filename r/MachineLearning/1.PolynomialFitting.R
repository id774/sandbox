# 1.PolynomialFitting.R: Polynomial curve fitting by least squares
#
# Description:
# Fit polynomials of several orders to ten noisy samples of sin(2 pi x) by
# solving the least squares equations, and plot each fit. The plots are
# written to image.png in the current directory.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript 1.PolynomialFitting.R
#
# Requirements:
# - R
#

png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
set.seed(0)
x<-seq(0.05,1,0.1)
t<-sin(2*pi*x)+rnorm(10,0,0.5)
makeA<-function(m){
    A<-matrix(nrow=m+1,ncol=m+1)
	for (i in 0:m) {
		for (j in 0:m) {
			A[1+i,1+j]<-sum(x^(i+j))
		}
	}
	A
}
makeB<-function(m){
	b<-0:m
	for (i in 0:m) {
		b[i+1]<-sum(x^i*t)
	}
	b
}
xrange<-c(-0.5,1.5)
yrange<-c(-2,2)
plot(x,t,xlim=xrange,ylim=yrange)
mrange=1:9
for (M in mrange) {
	A<-makeA(M)
	b<-makeB(M)
	w<-solve(A,b)
	estimate<-function(x){
		i <- 0:(length(w)-1)
		(sapply(x,function(xn){ (sum(w*xn^i)) })) # (w[1]+w[2]*x+w[3]*x^2+w[4]*x^3...)
	}
	par(new=T)
	curve(estimate,type="l",xlim=xrange,ylim=yrange,col=M)
}
legend("topleft",legend=mrange,col=mrange,lty=1,cex=0.5)
dev.off()
