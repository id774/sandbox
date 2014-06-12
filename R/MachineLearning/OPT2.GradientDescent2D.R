png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
frame()
par(mfcol=c(1, 2))
par(mar=c(2, 2, 1, 0.1))
par(mgp=c(1, 0.2, 0))

search <- function(x0, delta, f, df) {
	
	x <- x0
	h <- 0.7
	eps <- 1e-6
	i <- 1
	# 解の移動量が十分小さくなるまで繰り返す。
	repeat {
		oldx <- x
		# df(x)の符号によって、進む方向を決める。
		h <- sign(df(x)) * abs(h)
		newx <- x + h * delta
		if (f(x) < f(newx)) {
			# 関数値が増大する限り、ステップ幅を倍にしていく。
			repeat {
				h <- 2 * h
				x <- newx
				newx <- x + h * delta
				if (f(x) >= f(newx)) {
					break
				}
			}
			h <- h / 2
		} else {
			# 関数値が減少してしまうときは、ステップ幅を半分にしていき、
			# 関数値が増大する位置を見つける。
			repeat {
				h <- h / 2
				newx <- x + h * delta
				if (f(x) <= f(newx)) {
					break
				}
			}
			x <- newx
			h <- 2 * h
		}
		cat("search i=", i, "x=" , x, "f(x)=", f(x), "df(x)=", df(x), "h=", h, "\n")
		if (abs(h) < eps) {
			break
		}
		i <- i + 1
	}
	x
}

hillclimb <- function(x, f, dx, dy) {
	
	eps <- 1e-12
	i <- 1
	repeat {
		# 探索直線x(t)=x0+t*∇f0を求める。
		gradientf0 <- c(dx(x), dy(x))
		cat("hillclimb i=", i, "x=" , x, "f(x)=", f(x), "gradientf0=", gradientf0, "\n")
		# 探索直線上の関数F(t)=f(x(t))について、1階微分dF/dt=∇f^T * ∇f0を求める。
		df <- function(x) { as.numeric(c(dx(x), dy(x)) %*% gradientf0) }
		# 探索直線の方向ベクトルを正規化する。
		delta <- scale(gradientf0, center=F)
		# 直線探索する。
		newx <- search(x, delta, f, df)
		# 軌跡を描画する。
		xy <- cbind(x, newx)
		lines(xy[1, ], xy[2, ], type="o", col=1)
		diff = newx - x
		x <- newx
		# ||Δx||^2 が十分小さくなるまで繰り返す。
		if (sum(diff * diff) < eps) {
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
	hillclimb(c(1, 0.5), f, dx, dy)
}

f <- function(x){ -x[1] ^ 2 - 4 * x[2] ^ 2 + 5 * x[1] }
dx <- function(x){ -2 * x[1] + 5 }
dy <- function(x){ - 8 * x[2] }
draw()

f <- function(x){ cos(x[1]) + cos(x[2]) }
dx <- function(x){ -sin(x[1]) }
dy <- function(x){ -sin(x[2]) }
draw()

# f <- function(x){ -(x[1] ^ 3 + x[2] ^ 3 - 9 * x[1] * x[2] + 27) }
# dx <- function(x){ -(3 * x[1] ^ 2 - 9 * x[2]) }
# dy <- function(x){ -(3 * x[2] ^ 2 - 9 * x[1]) }
# draw()
dev.off()
