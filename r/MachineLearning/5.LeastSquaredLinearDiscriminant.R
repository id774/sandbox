png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
library(MASS)
frame()
par(mfrow=c(1,2))
set.seed(0)
x<-mvrnorm(40, c(0,1), matrix(c(2, 1.9, 1.9, 2), 2))
d1<-as.data.frame(cbind(x, 1, 1, 0))
x<-mvrnorm(40, c(2,0), matrix(c(2, 1.9, 1.9, 2), 2))
d1<-rbind(d1, as.data.frame(cbind(x, 2, 0, 1)))
x<-mvrnorm(10, c(7,-7), matrix(c(.2, 0, 0, .2), 2))
d2<-rbind(d1, as.data.frame(cbind(x, 2, 0, 1)))
names(d1)<-c("x1","x2","class","t1","t2")
names(d2)<-c("x1","x2","class","t1","t2")

doplot<-function(d) {
    xrange<-c(-4, 8)
	yrange<-c(-8, 4)
	base<-function(x1, x2) {
		(cbind(1, x1, x2))   # w0をバイアス項とするためφ0=1
	}
	phi<-base(d$x1, d$x2)
	t<-cbind(d$t1, d$t2)
	w<-solve(t(phi) %*% phi) %*% t(phi) %*% t
	print(w)
	estimate<-function(x1, x2, index){
		(t(w) %*% t(base(x1, x2)))[index,]
	}
	x1<-seq(-4,8,.1)
	x2<-seq(-8,4,.1)
	t1<-outer(x1, x2, estimate, 1)
	t2<-outer(x1, x2, estimate, 2)
	plot(d$x1, d$x2, col=d$class,xlim=xrange,ylim=yrange)
	contour(x1,x2,t2-t1,xlim=xrange,ylim=yrange,add=T)
}

doplot(d1)
doplot(d2)
dev.off()
