
# http://oku.edu.mie-u.ac.jp/~okumura/stat/141026.html

x = c(1498, 1605, 1707, 1854)
dx = diff(x)
mean(dx)
sd(dx) / mean(dx)
2011 - x[4]

m = 120
a = 0.2
bpt = function(t) { (m/(2*pi*a^2*t^3))^(1/2)*exp(-(t-m)^2/(2*a^2*m*t)) }
integrate(bpt, 157, 187)
integrate(bpt, 157, Inf)
0.06356807 / 0.07306916

png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
plot(NULL, xlim=c(0,250), ylim=c(0,max(bpt(110:130))), axes=FALSE, xlab="", ylab="")

axis(1, c(0,120,157,187,250))
x = seq(157,187,5)
y = bpt(x)
polygon(c(x,x[length(x)],x[1]), c(y,0,0), col=gray(0.6))
x = seq(187,250,7)
y = bpt(x)
polygon(c(x,x[length(x)],x[1]), c(y,0,0), col=gray(0.9))
curve(bpt(x), lwd=2, add=TRUE)

integrate(bpt, 157, 158)
0.004361829 / 0.07306916

dev.off()
