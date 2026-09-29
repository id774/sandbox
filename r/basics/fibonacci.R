# fibonacci.R: The first 20 Fibonacci numbers
#
# Description:
# Print the first 20 Fibonacci numbers, filled into a preallocated vector.
#
# Part of the basics cross-language exercise set: the input is fixed in the
# source, and the output is the same as that of the same exercise in every
# other language. The exercises are specified in README.md at the
# repository root.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript fibonacci.R
#
# Requirements:
# - R 4.0 or later (Rscript)
# - No third-party package is required

fibonacci <- function(count) {
  values <- integer(count)
  current <- 0L
  following <- 1L
  for (i in seq_len(count)) {
    values[i] <- current
    step <- current + following
    current <- following
    following <- step
  }
  values
}

cat(paste(fibonacci(20), collapse = " "), "\n", sep = "")
