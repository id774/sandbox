png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
library(igraph)
frame()
set.seed(0)
par(mfrow=c(3, 3))
par(mar=c(2, 2, 1, 0))
par(mgp=c(1, 0, 0))
K <- 3
N <- 4
ROOT <- 3
g <- graph(c(1, N+1, N+1, 2, 4, N+2, N+2, 2, 2, N+3, N+3, 3), directed=F)
V(g)$size <- 40
V(g)$label.cex <- 1.5
V(g)$shape <- "circle"
V(g)$shape[(N+1):(N+3)] <- "square"

potential1 <- function(n, xparent, xchild) {
	# 因数ノードnのポテンシャル関数
	#	xparent:上層変数ノード
	#	xchild:下層変数ノード
	
	p <- ifelse(xparent == xchild, 0.8, 0.1)
}
potential2 <- function(n, xparent, xchild) {
	
	p <- potential1(n, xparent, xchild)
	# 変数ノード1に1を観測
	OBSERVED <- 1
	if (n == 5) {
		p <- p * ifelse(xchild == OBSERVED, 1, 0)
	}
	p
}
potential3 <- function(n, xparent, xchild) {
	
	p <- potential1(n, xparent, xchild)
	# 変数ノード2に1を観測
	OBSERVED <- 1
	if (n == 5 || n == 6) {
		p <- p * ifelse(xparent == OBSERVED, 1, 0)
	} else if (n == 7) {
		p <- p * ifelse(xchild == OBSERVED, 1, 0)
	}
	p
}

doplot.joint <- function(potential) {
	
	# 同時分布を求める
	d <- data.frame()
	for (i in 0:(K^N - 1)) {  # O(K^N)
		total.potential <- 1
		xs <- c()
		xs <- c(xs, (i) %% K)
		for (n in 1:(N-1)) {
			xn1 <- (i %/% K ^ (n - 1)) %% K
			xn2 <- (i %/% K ^ n) %% K
			xs <- c(xs, xn2)
		}
		total.potential <- (potential(5, xs[2], xs[1]) * potential(6, xs[2], xs[4]) * potential(7, xs[3], xs[2]))
		d <- rbind(d, c(xs, total.potential))
	}
	names(d) <- c(paste0("x", 1:N), "p")
	cat("p(x)\n");print(rbind(head(d),tail(d)))

	# 同時分布の和により周辺分布を求める
	ps <- matrix(nrow=N, ncol=K)
	rownames(ps) <- 1:N
	colnames(ps) <- 0:(K-1)
	z <- sum(d$p)
	for (n in 1:N) {
		for (xn in 0:(K-1)) {
			ps[n, xn + 1] <- sum(d[d[, n] == xn, ]$p) / z
		}
	}
	cat("p(xn)\n");print(ps)
	barplot(t(ps), legend=0:(K-1), xlab="xn", ylab="p(xn)")
	title("sum of joint")
}

doplot.message <- function(potential) {
	
	mu <- as.data.frame(matrix(c(-1, -1, rep(NA, K)), ncol=2 + K))
	names(mu) <- c("from", "to", 0:(K-1))

	mufxUp <- function(from, to) {
		# 下層からのメッセージを求め、それを基に、因子ノードfromから変数ノードtoへのメッセージを求める
		
		# 下層からのメッセージを先に求める
		children <- neighbors(g, from)
		for (child in children) {
			if (child != to) {
				muxfUp(child, from)
			}
		}
		# to以外からのメッセージ(の積)にポテンシャルを掛けたものの、to以外の確率変数値に関する和を求める
		p <- rep(NA, K)
		for (x in 0:(K-1)) {  # O(K^隣接ノード数)
			m <- as.matrix(mu[mu$from == children[children != to] & mu$to == from, c(-1, -2)])
			p[x + 1] <- sum(potential(from, x, 0:(K-1)) * m)
		}
		mu <<- rbind(mu, c(from, to, p))
		p
	}
	muxfUp <- function(from, to) {
		# 下層からのメッセージを求め、それを基に、変数ノードfromから因子ノードtoへのメッセージを求める
		
		# to以外のメッセージ(の積)を求める
		p <- rep(1, K)
		for (child in neighbors(g, from)) {
			if (child != to) {
				p <- p * mufxUp(child, from)
			}
		}
		mu <<- rbind(mu, c(from, to, p))
		p
	}
	mufxDown <- function(from, to) {
		# 因子ノードfromから変数ノードtoへのメッセージを求め、それを基に下層へのメッセージも求める
		
		# to以外からのメッセージ(の積)にポテンシャルを掛けたものの、to以外の確率変数値に関する和を求める
		children <- neighbors(g, from)
		p <- rep(NA, K)
		for (x in 0:(K-1)) {  # O(K^隣接ノード数)
			m <- as.matrix(mu[mu$from == children[children != to] & mu$to == from, c(-1, -2)])
			p[x + 1] <- sum(potential(from, 0:(K-1), x) * m)
		}
		mu <<- rbind(mu, c(from, to, p))
		# 下層へのメッセージを求める
		for (child in neighbors(g, to)) {
			if (child != from) {
				muxfDown(to, child)
			}
		}
		p
	}
	muxfDown <- function(from, to) {
		# 変数ノードfromから因子ノードtoへのメッセージを求め、それを基に下層へのメッセージも求める
		
		# to以外のメッセージ(の積)を求める
		p <- rep(1, K)
		for (child in neighbors(g, from)) {
			if (child != to) {
				p <- p * as.matrix(mu[mu$from == child & mu$to == from, c(-1, -2)])
			}
		}
		mu <<- rbind(mu, c(from, to, p))
		# 下層へのメッセージを求める
		for (child in neighbors(g, to)) {
			if (child != from) {
				mufxDown(to, child)
			}
		}
		p
	}
	
	mufxUp(neighbors(g, ROOT)[1], ROOT)
	muxfDown(ROOT, neighbors(g, ROOT)[1])
	cat("mu\n");print(mu)
	ps <- matrix(nrow=N, ncol=K)
	rownames(ps) <- 1:N
	colnames(ps) <- 0:(K-1)
	for (n in 1:N) {
		p <- apply(mu[mu$to == n, c(-1, -2)], 2, prod)
		z <- sum(p)
		ps[n, ] <- p / z
	}
	barplot(t(ps), legend=0:(K-1), xlab="xn", ylab="p(xn)")
	title("message passing")
}

V(g)$color="white"
plot(g, layout=layout.reingold.tilford(g, root=ROOT))
doplot.joint(potential1)
doplot.message(potential1)

V(g)$color="white"
V(g)$color[1]="gray"
plot(g, layout=layout.reingold.tilford(g, root=ROOT))
doplot.joint(potential2)
doplot.message(potential2)

V(g)$color="white"
V(g)$color[2]="gray"
plot(g, layout=layout.reingold.tilford(g, root=ROOT))
doplot.joint(potential3)
doplot.message(potential3)
dev.off()
