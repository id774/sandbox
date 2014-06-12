png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
frame()
set.seed(0)
par(mfcol=c(2, 2))
par(mar=c(2, 2, 1, 0))
par(mgp=c(1, 0, 0))
N <- 7
K <- 3
potential1 <- function(n, x1, x2) {
	# p(x1)
	if (n == 1) {
		p <- ifelse(x1 == 2, 0.8, 0.1)
	} else {
		p <- 1
	}
	# p(xn|xn-1)
	p <- p * ifelse(x1 == x2, 0.8, 0.1)
	p
}
potential2 <- function(n, x1, x2) {
	# p(x1)
	if (n == 1) {
		p <- ifelse(x1 == 2, 0.8, 0.1)
	} else {
		p <- 1
	}
	# p(xn|xn-1)
	p <- p * ifelse(x1 == x2, 0.8, 0.1)
	# x4に1を観測
	OBSERVED <- 1
	if (n == 4) {
		p <- p * ifelse(x1 == OBSERVED, 1, 0)
	} else if (n + 1 == 4) {
		p <- p * ifelse(x2 == OBSERVED, 1, 0)
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
			psi <- potential(n, xn1, xn2)
			total.potential <- total.potential * psi
		}
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
	# 前方からのメッセージパッシング
	mualpha <- matrix(nrow=N, ncol=K)
	colnames(mualpha) <- 0:(K-1)
	mualpha[1, ] <- rep(1, K)
	for (n in 2:N) {  # O(N*K^2)
		mu <- c()
		for (x2 in 0:(K-1)) {  # O(K^2)
			mu <- c(mu, sum(potential(n - 1, 0:(K-1), x2) * mualpha[n - 1, ]))
		}
		mualpha[n, ] <- mu
	}
	cat("mualpha\n");print(mualpha)

	# 後方からのメッセージパッシング
	mubeta <- matrix(nrow=N, ncol=K)
	colnames(mubeta) <- 0:(K-1)
	mubeta[N, ] <- rep(1, K)
	for (n in (N-1):1) {  # O(N*K^2)
		mu <- c()
		for (x1 in 0:(K-1)) {  # O(K^2)
			mu <- c(mu, sum(potential(n, x1, 0:(K-1)) * mubeta[n + 1, ]))
		}
		mubeta[n, ] <- mu
	}
	cat("mubeta\n");print(mubeta)

	# メッセージに基づく周辺分布の計算
	ps <- matrix(nrow=N, ncol=K)
	rownames(ps) <- 1:N
	colnames(ps) <- 0:(K-1)
	for (n in 1:N) {
		p <- mualpha[n, ] * mubeta[n, ]
		z <- sum(p)
		ps[n, ] <- p / z
	}
	cat("p(xn)\n");print(ps)
	barplot(t(ps), legend=0:(K-1), xlab="xn", ylab="p(xn)")
	title("message passing")
}

doplot.joint(potential1)
doplot.message(potential1)
doplot.joint(potential2)
doplot.message(potential2)
dev.off()
