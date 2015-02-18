x = c(1,3,5,8,5,4,2)
g = factor(c(1,1,2,2,2,3,3))

plot(1:7, x, pch=16, xlab="", ylab="", axes=FALSE)
text((1:7)+0.2, x, x)
lines(c(1,2), c(2,2))
lines(c(3,5), c(6,6))
lines(c(6,7), c(3,3))
