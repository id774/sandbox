# Multiply two fixed 3x3 integer matrices, written out rather than left to the %*% of R.
# Run: Rscript matrix.R

left <- matrix(c(2, -1, 0, 1, 3, 4, 0, 5, -2), nrow = 3, byrow = TRUE)
right <- matrix(c(1, 0, 2, -3, 1, 1, 4, 2, 0), nrow = 3, byrow = TRUE)

multiply <- function(a, b) {
  product <- matrix(0, nrow = nrow(a), ncol = ncol(b))
  for (i in seq_len(nrow(a))) {
    for (j in seq_len(ncol(b))) {
      product[i, j] <- sum(a[i, ] * b[, j])
    }
  }
  product
}

determinant <- function(m) {
  m[1, 1] * (m[2, 2] * m[3, 3] - m[2, 3] * m[3, 2]) -
    m[1, 2] * (m[2, 1] * m[3, 3] - m[2, 3] * m[3, 1]) +
    m[1, 3] * (m[2, 1] * m[3, 2] - m[2, 2] * m[3, 1])
}

product <- multiply(left, right)

for (i in seq_len(nrow(product))) {
  cat(paste(product[i, ], collapse = " "), "\n", sep = "")
}
cat(determinant(product), "\n", sep = "")
