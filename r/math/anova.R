
# http://oku.edu.mie-u.ac.jp/~okumura/stat/anova.html

x = c(1,3,5,8,5,4,2)
g = factor(c(1,1,2,2,2,3,3))

png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
plot(1:7, x, pch=16, xlab="", ylab="", axes=FALSE)
text((1:7)+0.2, x, x)
lines(c(1,2), c(2,2))
lines(c(3,5), c(6,6))
lines(c(6,7), c(3,3))
dev.off()

y = ave(x, g)
z = ave(x)
y - z
sum((y-z)^2)
x - y
sum((x-y)^2)
x - z
sum((x-z)^2)

(sum((y-z)^2) / 2) / (sum((x-y)^2) / 4)
1 - pf(4.4, 2, 4)

par(mgp=c(1.8,0.6,0))
png("image2.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
plot(NULL, xlim=c(0,10), ylim=c(0,1), xlab="", ylab="")
s = seq(4.4, 10, 0.1)
polygon(c(s,10,4.4), c(df(s,2,4),0,0), col="yellow")
curve(df(x,2,4), lwd=2, add=T)
dev.off()

anova(lm(x ~ g))
summary(aov(x ~ g))

# oneway.test(x ~ g, var.equal=TRUE)
oneway.test(x ~ g)

