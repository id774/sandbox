png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
frame()
par(mfcol=c(1, 1))
par(mar=c(2, 2, 1, 0.1))
par(mgp=c(1, 0.2, 0))
xrange <- c(-3, 3)
yrange <- c(-1, 1)
f <- function(x) { cos(x) }
dx <- function(x) { -sin(x) }
dxdx <- function(x) { -cos(x) }
newton <- function(x0, f, df, d2f) {
	
	x <- x0
	eps <- 1e-6
	i <- 1
	# ‰ð‚ÌˆÚ“®—Ê‚ª\•ª¬‚³‚­‚È‚é‚Ü‚ÅŒJ‚è•Ô‚·B
	repeat {
		oldx <- x
		x <- x - df(x) / d2f(x)
		lines(c(oldx, x), c(i - 1, i) * 0.05 - 0.5, type="o", col=2)
		cat("i=", i, "x=" , x, "f(x)=", f(x), "df(x)=", df(x), "\n")
		if (abs(x - oldx) < eps) {
			break
		}
		i <- i + 1
	}
	x
}

curve(f, xlim=range(xrange), ylim=range(yrange))
newton(-1, f, dx, dxdx)
dev.off()
