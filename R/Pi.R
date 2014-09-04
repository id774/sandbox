s <- 10000000
x <- runif(s)
y <- runif(s)
sum(x^2+y^2 <= 1)*4/s
