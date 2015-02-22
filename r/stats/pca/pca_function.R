
# http://aoki2.si.gunma-u.ac.jp/R/pca.html

pca <- function(dat)
{
    if (is.null(rownames(dat))) rownames(dat) <- paste("#", 1:nrow(dat), sep="")
    dat <- subset(dat, complete.cases(dat))        # 欠損値を持つケースを除く
    nr <- nrow(dat)                                # サンプルサイズ
    nc <- ncol(dat)                                # 変数の個数
    if (is.null(colnames(dat))) {
        colnames(dat) <- paste("X", 1:nc, sep="")
    }
    vname <- colnames(dat)
    heikin <- colMeans(dat)                        # 各変数の平均値
    bunsan <- apply(dat, 2, var)                   # 各変数の不偏分散
    sd <- sqrt(bunsan)                             # 各変数の標準偏差
    r <-cor(dat)                                   # 相関係数行列
    result <- eigen(r)                             # 固有値・固有ベクトルを求める
    eval <- result$values                          # 固有値
    evec <- result$vectors                         # 固有ベクトル
    contr <- eval/nc*100                           # 寄与率（％）
    cum.contr <- cumsum(contr)                     # 累積寄与率（％）
    fl <- t(sqrt(eval)*t(evec))                    # 主成分負荷量
    fs <- scale(dat)%*%evec*sqrt(nr/(nr-1))        # 主成分得点
    names(heikin) <- names(bunsan) <- names(sd) <-
        rownames(r) <- colnames(r) <- rownames(fl) <- colnames(dat)
    names(eval) <- names(contr) <- names(cum.contr) <-
        colnames(fl) <- colnames(fs) <- paste("PC", 1:nc, sep="")
    return(structure(list(mean=heikin, variance=bunsan,
            standard.deviation=sd, r=r,
            factor.loadings=fl, eval=eval,
            contribution=contr,
            cum.contribution=cum.contr, fs=fs), class="pca"))
}

print.pca <- function(     obj,   # pca が返すオブジェクト
            npca=NULL,            # 表示する主成分数
            digits=3)             # 結果の表示桁数
{
    eval <- obj$eval
    nv <- length(eval)
    if (is.null(npca)) {
        npca <- sum(eval >= 1)
    }
    eval <- eval[1:npca]
    cont <- eval/nv
    cumc <- cumsum(cont)
    fl <- obj$factor.loadings[, 1:npca, drop=FALSE]
    rcum <- rowSums(fl^2)
    vname <- rownames(fl)
    max.char <- max(nchar(vname), 12)
    fmt1 <- sprintf("%%%is", max.char)
    fmt2 <- sprintf("%%%is", digits+5)
    fmt3 <- sprintf("%%%i.%if", digits+5, digits)
    cat("\n主成分分析の結果\n\n")
    cat(sprintf(fmt1, ""),
      sprintf(fmt2, c(sprintf("PC%i", 1:npca), "  Contribution")), "\n", sep="", collapse="")
    for (i in 1:nv) {
        cat(sprintf(fmt1, vname[i]),
          sprintf(fmt3, c(fl[i, 1:npca], rcum[i])),
          "\n", sep="", collapse="")
    }
    cat(sprintf(fmt1, "Eigenvalue"),   sprintf(fmt3, eval[1:npca]), "\n", sep="", collapse="")
    cat(sprintf(fmt1, "Contribution"), sprintf(fmt3, cont[1:npca]), "\n", sep="", collapse="")
    cat(sprintf(fmt1, "Cum.contrib."), sprintf(fmt3, cumc[1:npca]), "\n", sep="", collapse="")
    
}

summary.pca <- function(obj,      # pca が返すオブジェクト
            digits=5)             # 結果の表示桁数
{
    print.default(obj, digits=digits)
}

plot.pca <- function(    obj,              # pca が返すオブジェクト
            which=c("loadings", "scores"), # 主成分負荷量か主成分得点か
            pc.no=c(1,2),                  # 描画する主成分番号
            ax=TRUE,                       # 座標軸を描き込むかどうか
            label.cex=0.6,                 # 主成分負荷量のプロットのラベルのフォントサイズ
            ...)                           # plot に引き渡す引数
{
    which <- match.arg(which)
    if (which == "loadings") {
        d <- obj$factor.loadings
    }
    else {
        d <- obj$fs
    }
    label <- sprintf("第%i主成分", pc.no)
    plot(d[, pc.no[1]], d[, pc.no[2]], xlab=label[1], ylab=label[2], ...)
    if (which == "loadings") {
        text(d[, pc.no[1]], d[, pc.no[2]], rownames(obj$factor.loadings), pos=1, cex=label.cex)
    }
    abline(h=0, v=0)
}


set.seed(123)
x <- matrix(rnorm(1000), 100)
colnames(x) <- paste("X", 1:10, sep="")
a <- pca(x)
print(a) # print メソッドによる出力
