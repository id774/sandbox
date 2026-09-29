# pascal.R: The first 10 rows of Pascal's triangle
#
# Description:
# Print 10 rows of Pascal's triangle, each row summed from the previous one shifted both ways.
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
#     Rscript pascal.R
#
# Requirements:
# - R 4.0 or later (Rscript)
# - No third-party package is required

rows <- 10

row <- 1
for (i in seq_len(rows)) {
  cat(paste(row, collapse = " "), "\n", sep = "")
  row <- c(0, row) + c(row, 0)
}
