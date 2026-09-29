# matrix.R: Product and determinant of two fixed 3x3 integer matrices
#
# Description:
# Multiply two fixed 3x3 integer matrices, written out rather than left to the %*% of R.
#
# Part of the math cross-language exercise set: it reads no arguments or
# standard input, keeps its data fixed in the source, uses integer
# arithmetic only, and its output is the same as that of the same exercise
# in every other language. The exercises are specified in README.md at the
# repository root.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript matrix.R
#
# Requirements:
# - R 4.0 or later (Rscript)
# - No third-party package is required

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
