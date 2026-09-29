# gcd_lcm.R: GCD and LCM of fixed pairs by Euclid's algorithm
#
# Description:
# Print the divisor and multiple of fixed pairs, with Euclid's algorithm written as a while loop.
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
#     Rscript gcd_lcm.R
#
# Requirements:
# - R 4.0 or later (Rscript)
# - No third-party package is required

pairs <- list(c(1071, 462), c(270, 192), c(17, 5), c(120, 36))

euclid <- function(first, second) {
  while (second != 0) {
    remainder <- first %% second
    first <- second
    second <- remainder
  }
  first
}

for (pair in pairs) {
  first <- pair[1]
  second <- pair[2]
  divisor <- euclid(first, second)
  cat(paste(c(first, second, divisor, (first %/% divisor) * second), collapse = " "), "\n", sep = "")
}
