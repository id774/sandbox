# 重回帰分析
mreg <- function(	dat,					# データ行列
			func.name=c("solve", "ginv"))		# 逆行列を計算する関数の選択
{
	dat <- subset(dat, complete.cases(dat))			# 欠損値を持つケースを除く
	n <- nrow(dat)						# ケース数
	nc <- ncol(dat)						# 列数
	nv <- nc-1						# 独立変数の個数（最後の一つは従属変数）
	if (is.null(colnames(dat))) {				# 変数名が付いていないときには仮の名前を付ける
		colnames(dat) <- paste("Var", 1:nc, sep="")
	}
	r <- cor(dat)						# 相関係数行列
	m <- colMeans(dat)[-nc]					# 独立変数の平均値ベクトル
	if (match.arg(func.name) == "solve") {
		inverse <- solve
		betas <- inverse(r[-nc, -nc], r[,nc][-nc])	# 標準化偏回帰係数
	}
	else {
		library(MASS)
		inverse <- ginv
		betas <- inverse(r[-nc, -nc]) %*% r[,nc][-nc]	# 標準化偏回帰係数
	}
	variance <- var(dat)*(n-1)				# 変動共変動行列
	prop <- diag(variance)					# 対角成分
	prop <- (prop/prop[nc])[-nc]				# 偏回帰係数に変換するための係数（独立変数の変動/従属変数の変動）
	b <- betas/sqrt(prop)					# 偏回帰係数
	Sr <- variance[,nc][-nc]%*%b				# 回帰による変動
	St <- variance[nc, nc]					# 全変動
	Se <- St-Sr						# 誤差変動
	SS <- c(Sr, Se, St)					# 平方和（変動）ベクトル
	dfr <- nv						# 回帰による変動の自由度
	dfe <- n-nv-1						# 誤差変動の自由度
	dft <- n-1						# 全変動の自由度
	df <- c(dfr, dfe, dft)					# 自由度ベクトル
	Ms <- SS/df						# 平均平方ベクトル
	f <- Ms[1]/Ms[2]					# F 値
	fvalue <- c(f, NA, NA)
	p <- c(pf(f, dfr, dfe, lower.tail=FALSE), NA, NA) 	# P 値
	b0 <- mean(dat[,nc])-sum(b*m)				# 定数項
	b <- c(b, b0)						# 偏回帰係数ベクトル
	inv <- inverse((n-1)*cov(dat)[-nc, -nc])
	SEb <- c(sapply(1:nv, function(i) sqrt(inv[i, i]*Ms[2])), sqrt((1/n+m%*%inv%*%m)*Ms[2]))
	tval <- b/SEb						# 偏回帰係数の有意性検定
	pval <- pt(abs(tval), n-nv-1, lower.tail=FALSE)*2	# P 値
	tolerance <- 1/diag(inverse(cor(dat)[-nc, -nc]))	# トレランス
	result <- cbind(b, SEb, tval, pval, c(betas, NA), c(tolerance, NA))
	rownames(result) <- c(colnames(dat)[1:nv], "定数項")
	colnames(result) <- c("偏回帰係数", "標準誤差", "t 値", "P 値", "標準化偏回帰係数", "トレランス")
	R2 <- 1-Se/St						# 重相関係数の二乗
	R <- sqrt(R2)						# 重相関係数
	R2s <- 1-Ms[2]/Ms[3]					# 自由度調整済み重相関係数の二乗
	loglik <- -0.5*n*(log(2*pi)+1-log(n)+log(Se))	# 対数尤度
	AIC <- 2*nc+2-2*loglik					# AIC
	Rs <- c("重相関係数"=R, "重相関係数の二乗"=R2, "自由度調整済重相関係数の二乗"=R2s,
		"対数尤度"=loglik, "AIC"=AIC)
	anova <- cbind(SS, df, Ms, fvalue, p)			# 分散分析表
	rownames(anova) <- c("回帰", "残差", "全体")
	colnames(anova) <- c("平方和", "自由度", "平均平方", "F 値", "P 値")
	return(structure(list(result=result, anova=anova, Rs=Rs), class="mreg"))
}
# print メソッド
print.mreg <- function(	obj,					# mreg が返すオブジェクト
			digits=5)				# 結果の表示桁数
{
	print(obj$result, digits=digits, na.print="")
	cat("\n回帰の分散分析表\n\n")
	print(obj$anova, digits=digits, na.print="")
	cat("\n")
	sapply(1:length(obj$Rs), function(i) cat(names(obj$Rs)[i], "=", round(obj$Rs[i], digits), "\n"))
}

