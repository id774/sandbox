png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
set.seed(0)
x<-seq(0.05,1,0.1)
t<-sin(2*pi*x)+rnorm(10,0,0.5)
t<-matrix(t,nrow=length(t))
M<-4
base<-function(m,x) {
#       r<-x^m                          #多項式基底の場合
        r<-exp(-(x-(m-1)/(M-2))^2/(2*0.2^2))    #ガウス基底の場合
        r[m == 0]<-1                    # w0をバイアス項とするためφ0=1
        r
}
makePhi<-function(M) {
        A <- matrix(nrow=length(x),ncol=M)
        for (i in 1:length(x)) {
                for (j in 0:(M-1)) {
                        A[i,1+j] <- base(j,x[i])
                }
        }
        A
}
xrange<-c(-0.5,1.5)
yrange<-c(-2,2)
phi<-makePhi(M)
w<-solve(t(phi) %*% phi) %*% t(phi) %*% t
w
estimate<-function(x){
        i <- 0:(M-1)
        (sapply(x,function(xn){ (sum(w * base(i, xn))) } )) # (w[1]+w[2]*base(1,x)+w[3]*base(2,x)...)
}
plot(x,t,xlim=xrange,ylim=yrange)
par(new=T)
curve(estimate,type="l",xlim=xrange,ylim=yrange)
dev.off()
