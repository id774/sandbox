n = 10
A = matrix(rnorm(n*n),n,n) 
A %*% A
solve(A)
svd(A)
