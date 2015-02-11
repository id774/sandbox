sin_0.5 <- function (x) sin(x>0.5)

sin_0.5(runif(10))

sinv_0.5 <- function (x) {
    temp <- function(x) if (x<0) return(2) else return(3)
        sapply(x, temp) }

sinv_0.5(runif(10)-0.5)

ifelse(runif(10) - 0.5 < 0, 2, 3)
