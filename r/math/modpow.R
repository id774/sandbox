# modpow.R: Modular exponentiation of fixed triples by repeated squaring
#
# Description:
# Print modular powers of fixed triples, each squared and halved by repeated squaring.
# The products are parenthesised because %% and %/% bind tighter than * in R.
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
#     Rscript modpow.R
#
# Requirements:
# - R 4.0 or later (Rscript)
# - No third-party package is required

cases <- list(c(2, 1000, 1000003), c(3, 200, 50), c(5, 117, 19), c(10, 18, 9999991))

modpow <- function(base, exponent, modulus) {
  result <- 1
  base <- base %% modulus
  while (exponent > 0) {
    if (exponent %% 2 == 1) {
      result <- (result * base) %% modulus
    }
    base <- (base * base) %% modulus
    exponent <- exponent %/% 2
  }
  result
}

for (case in cases) {
  base <- case[1]
  exponent <- case[2]
  modulus <- case[3]
  cat(paste(c(base, exponent, modulus, modpow(base, exponent, modulus)), collapse = " "), "\n", sep = "")
}
