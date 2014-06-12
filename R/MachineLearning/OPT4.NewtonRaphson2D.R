png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
frame()
par(mfcol=c(1, 2))
par(mar=c(2, 2, 1, 0.1))
par(mgp=c(1, 0.2, 0))

newton <- function(x0, f, df, dxdx, dxdy, dydx, dydy) {
	
	x <- x0
	eps <- 1e-12
	i <- 1
	repeat {
		oldx <- x
		# 勾配∇fを求める。
		gradientf <- c(dx(x), dy(x))
		# ヘッセ行列Hを求める。
		H <- matrix(c(dxdx(x), dxdy(x), dydx(x), dydy(x)), 2, byrow=T)
		# HΔx=-∇fを解き、Δx=-H^-1 ∇fを求める。
		deltax <- solve(H, -gradientf)
		x <- x + deltax
		xy <- cbind(oldx, x)
		lines(xy[1, ], xy[2, ], type="o", col=1)
		cat("i=", i, "x=" , x, "f(x)=", f(x), "df(x)=", df(x), "\n")
		# ||Δx||^2 が十分小さくなるまで繰り返す。
		if (sum(deltax * deltax) < eps) {
			break
		}
		i <- i + 1
	}
	x
}

draw <- function() {
	xgrid <- seq(-3, 3, 0.1)
	ygrid <- seq(-3, 3, 0.1)
	zgrid <- outer(xgrid, ygrid, Vectorize(function(x, y){ f(c(x, y)) }))
	image(xgrid, ygrid, zgrid, xlim=range(xgrid), ylim=range(ygrid), xlab="x[1]", ylab="x[2]", main="f(x)", col=rainbow(450)[256:1])
	contour(xgrid, ygrid, zgrid, xlim=range(xgrid), ylim=range(ygrid), add=T)
	newton(c(1, 0.5), f, dx, dxdx, dxdy, dydx, dydy)
}

f <- function(x){ -x[1] ^ 2 - 4 * x[2] ^ 2 + 5 * x[1] }
dx <- function(x){ -2 * x[1] + 5 }
dy <- function(x){ - 8 * x[2] }
dxdx <- function(x){ -2 }
dxdy <- function(x){ 0 }
dydx <- function(x){ 0 }
dydy <- function(x){ -8 }
draw()

f <- function(x){ cos(x[1]) + cos(x[2]) }
dx <- function(x){ -sin(x[1]) }
dy <- function(x){ -sin(x[2]) }
dxdx <- function(x){ -cos(x[1]) }
dxdy <- function(x){ 0 }
dydx <- function(x){ 0 }
dydy <- function(x){ -cos(x[2]) }
draw()

# f <- function(x){ x[1] ^ 3 + x[2] ^ 3 - 9 * x[1] * x[2] + 27 }
# dx <- function(x){ 3 * x[1] ^ 2 - 9 * x[2] }
# dy <- function(x){ 3 * x[2] ^ 2 - 9 * x[1] }
# dxdx <- function(x){ 6 * x[1] }
# dxdy <- function(x){ -9 }
# dydx <- function(x){ -9 }
# dydy <- function(x){ 6 * x[2] }
# draw()
dev.off()
