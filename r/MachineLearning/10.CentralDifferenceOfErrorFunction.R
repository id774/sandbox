png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
frame()
set.seed(0)
par(mfcol=c(2, 3))
par(mar=c(3, 3, 1, 0.1))
par(mgp=c(2, 1, 0))
xrange <- c(-1.5, 1.5)
yrange <- c(-2, 2)
x <- seq(-1, 1, 1/25)
Zi <- rbind(x, 1) # bias input
#t <- x^2
t <- sin(x * pi)
#t <- abs(x)
#t <- sign(x)
EPS <- 0.001
ITERATION <- 5
I <- 2
J <- 4
K <- 1
Wji <- matrix(runif((J-1) * I), nrow=J - 1, ncol=I)
Wkj <- matrix(1, nrow=K, ncol=J)
activateJ <- function(a) {
    tanh(a)
}
dActivateJ <- function(a) {
    1 - tanh(a)^2
}
activateK <- function(a) {
    a
}
hidden <- function(x,j) {
    Aj <- Wji %*% rbind(x, 1) # append bias input
    Zj <- activateJ(Aj)
    Zj[j,]
}
estimate <- function(x){
    Aj <- Wji %*% rbind(x, 1) # append bias input
    Zj <- activateJ(Aj)
    Zj <- rbind(Zj, 1) # append bias input
    Ak <- Wkj %*% Zj
    Zk <- activateK(Ak)
    Zk
}
weights <- c()

for (iteration in 1:ITERATION) {
    col <- rainbow(ITERATION)[ITERATION / 2 + iteration / 2]

    par(mfg=c(1, 1))
    par(new=T)
    curve(hidden(x, 1), type="l", xlim=xrange, ylim=yrange, col=col)

    par(mfg=c(1, 2))
    par(new=T)
    curve(hidden(x, 2), type="l", xlim=xrange, ylim=yrange, col=col)

    par(mfg=c(1, 3))
    par(new=T)
    curve(hidden(x, 3), type="l", xlim=xrange, ylim=yrange, col=col)

    par(mfg=c(2, 3))
    par(new=T)
    curve(estimate, type="l", xlim=xrange, ylim=yrange, col=col)
    par(new=T)
    plot(x, t, xlim=xrange, ylim=yrange, xlab="", ylab="")

    par(mfg=c(2, 2))
    par(new=T)
    error <- log(sum((estimate(x) - t)^2 / 2))
    plot(iteration, error, type="p", cex=0.1, xlim=c(1, ITERATION), ylim=c(-5, 5), ylab="log(E(w))", col=col)

    # forward propagation
    Aj <- Wji %*% rbind(x, 1) # append bias input
    Zj <- activateJ(Aj)
    Zj <- rbind(Zj, 1) # append bias input
    Ak <- Wkj %*% Zj
    Zk <- activateK(Ak)

    # backward propagation
    deltaK <- Zk - t
    dEdWkj <- c()
    for (j in 1:nrow(Zj)) {
        for (k in 1:nrow(deltaK)) {
            dEdWkj <- rbind(dEdWkj, Zj[j,] * deltaK[k,])
        }
    }
    deltaJ <- dActivateJ(Aj[-J,]) * Wkj[,-J] %*% deltaK # no need to compute for a bias hidden unit
    dEdWji <- c()
    for (i in 1:nrow(Zi)) {
        for (j in 1:nrow(deltaJ)) {
            dEdWji <- rbind(dEdWji, Zi[i,] * deltaJ[j,])
        }
    }
    dEdWkjSum <- rowSums(dEdWkj)
    dEdWjiSum <- rowSums(dEdWji)
    dEdWjiMat <- matrix(dEdWjiSum, ncol=I, byrow=F)
    dEdWkjSumPerturb <- rep(NA, J)
    dEdWjiMatPerturb <- matrix(NA, nrow=J - 1, ncol=I)

    # perturb Wji
    for (i in 1:I) {
        for (j in 1:J-1) {
            old <- Wji[j,i]
            Wji[j,i] <- old + EPS
            eplus <- sum((estimate(x) - t)^2 / 2)
            Wji[j,i] <- old - EPS
            eminus <- sum((estimate(x) - t)^2 / 2)
            dEdWjiMatPerturb[j,i] <- (eplus - eminus) / (2 * EPS)
            Wji[j,i] <- old
        }
    }
    cat("perturbed"); print(dEdWjiMatPerturb)
    cat("back-prop"); print(dEdWjiMat)
    
    # perturb Wkj
    for (j in 1:J) {
        for (k in 1:K) {
            Wkj[k,j]
            old <- Wkj[k,j]
            Wkj[k,j] <- old + EPS
            eplus <- sum((estimate(x) - t)^2 / 2)
            Wkj[k,j] <- old - EPS
            eminus <- sum((estimate(x) - t)^2 / 2)
            dEdWkjSumPerturb[j] <- (eplus - eminus) / (2 * EPS)
            Wkj[k,j] <- old
        }
    }
    cat("perturbed"); print(dEdWkjSumPerturb)
    cat("back-prop"); print(dEdWkjSum)

    # gradient descent
    Wkj <- Wkj - 0.01 * dEdWkjSum
    Wji <- Wji - 0.01 * dEdWjiMat

    weights <- rbind(weights, c(as.vector(Wji), as.vector(Wkj)))
    par(mfg=c(2, 1))
    matplot(1:iteration, weights, type="l", lty=1, xlim=c(1, ITERATION), ylim=c(-10, 10), ylab="w")
}
dev.off()
