png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
library(igraph)
library(plotrix)
frame()
set.seed(0)
par(mfrow=c(3, 4))
par(mar=c(2, 2, 2, 0))
par(mgp=c(1, 0, 0))
K <- 3
N <- 4
ROOT <- 3
g <- graph(c(1, N+1, N+1, 2, 4, N+2, N+2, 2, 2, N+3, N+3, 3), directed=F)
V(g)$size <- 40
V(g)$label.cex <- 1.5
V(g)$shape <- "circle"
V(g)$shape[(N+1):(N+3)] <- "square"

pxy <- matrix(c(
	0.00, 0.00, 0.16,
	0.00, 0.00, 0.34,
	0.16, 0.34, 0.00
	), 3, byrow=T)
	
potential1 <- function(n, xparent, xchild) {
	# 因数ノードnのポテンシャル関数
	#	xparent:上層変数ノード
	#	xchild:下層変数ノード
	
	if (n == 7) {
		p <- pxy[xchild + 1, xparent + 1]
	} else {
		p <- ifelse(xparent == xchild, 0.8, 0.1)
	}
	p
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

doplot.marginal.joint <- function(potential) {
	
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
	title("marginal prob.")
}

doplot.max.joint <- function(potential) {
	
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

	# 同時分布が最大のものを求める
	z <- sum(d$p)
	d$p <- d$p / z
	pmax <- max(d$p)
	cat("p(xmax)\n");print(d[d$p == pmax, ])
	frame()
	addtable2plot(0, 0, table=round(d[d$p == pmax, ], 6))
	title("max joint prob.\nof all")
	z
}

doplot.max.message <- function(potential, z) {
	
	mu <- as.data.frame(matrix(c(-1, -1, rep(NA, K)), ncol=2 + K))
	names(mu) <- c("from", "to", 0:(K-1))
	phi <- as.data.frame(matrix(c(-1, -1, rep(NA, K)), ncol=2 + K))
	names(phi) <- c("from", "to", 0:(K-1))

	mufxUp <- function(from, to) {
		# 下層からのメッセージを求め、それを基に、因子ノードfromから変数ノードtoへのメッセージを求める
		
		# 下層からのメッセージを先に求める
		children <- neighbors(g, from)
		for (child in children) {
			if (child != to) {
				muxfUp(child, from)
			}
		}
		# to以外からのメッセージ(の和)にポテンシャルの対数を足したものの、to以外の確率変数値に関する最大値を求める
		p <- rep(NA, K)
		h <- rep(NA, K)
		for (x in 0:(K-1)) {  # O(K^隣接ノード数)
			m <- as.matrix(mu[mu$from == children[children != to] & mu$to == from, c(-1, -2)])
			s <- log(potential(from, x, 0:(K-1))) + m
			# 最大値を与えるxを記録する
			h[x + 1] <- which.max(s) - 1
			# 最大値を記録する
			p[x + 1] <- max(s[h[x + 1] + 1])
		}
		mu <<- rbind(mu, c(from, to, p))
		phi <<- rbind(phi, c(from, to, h))
		p
	}
	muxfUp <- function(from, to) {
		# 下層からのメッセージを求め、それを基に、変数ノードfromから因子ノードtoへのメッセージを求める
		
		# to以外のメッセージ(の和)を求める
		p <- rep(0, K)
		for (child in neighbors(g, from)) {
			if (child != to) {
				p <- p + mufxUp(child, from)
			}
		}
		mu <<- rbind(mu, c(from, to, p))
		p
	}
	backtrackFx <- function(from, to, xmax) {
		# 因子ノードfromから変数ノードtoへバックトラックする
		
		# 最大同時確率を与えるような、変数ノードtoにおけるxを記録する
		dmax[, to] <<- xmax
		
		# 下層へバックトラックする
		for (child in neighbors(g, to)) {
			if (child != from) {
				backtrackXf(to, child, xmax)
			}
		}
	}
	backtrackXf <- function(from, to, xmax) {
		# 変数ノードfromから因子ノードtoへバックトラックする
		
		# 変数ノードfromでxmaxを与えたxを求める
		h <- as.numeric(phi[phi$from == to & phi$to == from, c(-1, -2)])
		xprevious <- h[xmax + 1]
		
		# 下層へバックトラックする
		for (child in neighbors(g, to)) {
			if (child != from) {
				backtrackFx(to, child, xprevious)
			}
		}
	}
	
	# 下層からメッセージを送る
	mufxUp(neighbors(g, ROOT)[1], ROOT)
	cat("mu\n");print(mu)
	cat("phi\n");print(phi)
	
	# 根ノードxNへのメッセージの合計の最大値を与えるxを記録する
	m <- as.matrix(mu[mu$to == ROOT, c(-1, -2)])
	s <- colSums(m)
	xmax <- which(s == max(s)) - 1
	# その最大値が、最大同時確率となる
	pmax <- exp(s[xmax + 1]) / z
	
	# xmaxを基にバックトラックし、各xmaxの要素に対応するxを求める
	dmax <- data.frame(matrix(NA, ncol=N, nrow=length(xmax)), p = pmax)
	names(dmax) <- c(paste0("x", 1:N), "p")
	dmax[, ROOT] <- xmax
	backtrackXf(ROOT, neighbors(g, ROOT)[1], xmax)
	cat("p(xmax)\n");print(dmax)
	
	frame()
	addtable2plot(0, 0, table=round(dmax, 6))
	title("max joint prob.\nby max-sum")
}

V(g)$color="white"
plot(g, layout=layout.reingold.tilford(g, root=ROOT))
doplot.marginal.joint(potential1)
z <- doplot.max.joint(potential1)
doplot.max.message(potential1, z)

V(g)$color="white"
V(g)$color[1]="gray"
plot(g, layout=layout.reingold.tilford(g, root=ROOT))
doplot.marginal.joint(potential2)
z <- doplot.max.joint(potential2)
doplot.max.message(potential2, z)

V(g)$color="white"
V(g)$color[2]="gray"
plot(g, layout=layout.reingold.tilford(g, root=ROOT))
doplot.marginal.joint(potential3)
z <- doplot.max.joint(potential3)
doplot.max.message(potential3, z)
dev.off()
