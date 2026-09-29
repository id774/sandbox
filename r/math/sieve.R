# sieve.R: Primes below 100 by the sieve of Eratosthenes
#
# Description:
# Print the primes below 100, sieved over a logical vector read back with which.
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
#     Rscript sieve.R
#
# Requirements:
# - R 4.0 or later (Rscript)
# - No third-party package is required

limit <- 100

is_prime <- rep(TRUE, limit)
is_prime[1] <- FALSE

for (n in 2:floor(sqrt(limit))) {
  if (is_prime[n]) {
    is_prime[seq(n * n, limit, by = n)] <- FALSE
  }
}

cat(paste(which(is_prime), collapse = " "), "\n", sep = "")
