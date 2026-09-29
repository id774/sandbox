# quicksort.R: Quicksort of a fixed integer sequence
#
# Description:
# Sort a fixed vector with a quicksort over the head and tail of the vector.
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
#     Rscript quicksort.R
#
# Requirements:
# - R 4.0 or later (Rscript)
# - No third-party package is required

quicksort <- function(items) {
  if (length(items) <= 1) {
    return(items)
  }

  pivot <- items[1]
  rest <- items[-1]
  c(quicksort(rest[rest <= pivot]), pivot, quicksort(rest[rest > pivot]))
}

cat(paste(quicksort(c(5, 3, 8, 4, 2, 7, 1, 10, 9, 6)), collapse = " "), "\n", sep = "")
