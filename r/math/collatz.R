# collatz.R: Longest Collatz sequence for a start below 1000
#
# Description:
# Print the start below 1000 with the longest Collatz sequence, picked by which.max over a vector of lengths.
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
#     Rscript collatz.R
#
# Requirements:
# - R 4.0 or later (Rscript)
# - No third-party package is required

limit <- 1000

chain_length <- function(start) {
  value <- start
  count <- 1
  while (value != 1) {
    value <- if (value %% 2 == 0) value %/% 2 else value * 3 + 1
    count <- count + 1
  }
  count
}

starts <- seq_len(limit - 1)
chain_lengths <- vapply(starts, chain_length, numeric(1))
longest <- which.max(chain_lengths)

cat(paste(c(starts[longest], chain_lengths[longest]), collapse = " "), "\n", sep = "")
