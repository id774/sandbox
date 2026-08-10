png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
frame()
par(mfcol=c(1, 1))
par(mar=c(2, 2, 1, 0.1))
par(mgp=c(1, 0.2, 0))
xrange <- c(-3, 3)
yrange <- c(-1, 1)
f <- function(x) { cos(x) }
dx <- function(x) { -sin(x) }
search <- function(x0, f, df) {
	
	x <- x0
	h <- 0.7
	eps <- 1e-6
	i <- 1
	# 解の移動量が十分小さくなるまで繰り返す。
	repeat {
		oldx <- x
		# df(x)の符号によって、進む方向を決める。
		h <- sign(df(x)) * abs(h)
		newx <- x + h
		if (f(x) < f(newx)) {
			# 関数値が増大する限り、ステップ幅を倍にしていく。
			repeat {
				h <- 2 * h
				x <- newx
				newx <- x + h
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
				newx <- x + h
				if (f(x) <= f(newx)) {
					break
				}
			}
			x <- newx
			h <- 2 * h
		}
		lines(c(oldx, x), c(i - 1, i) * 0.05 - 0.5, type="o", col=2)
		cat("i=", i, "x=" , x, "f(x)=", f(x), "df(x)=", df(x), "h=", h, "\n")
		if (abs(h) < eps) {
			break
		}
		i <- i + 1
	}
	x
}

curve(f, xlim=range(xrange), ylim=range(yrange))
search(-1, f, dx)
dev.off()
