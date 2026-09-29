# fizzbuzz.R: FizzBuzz for 1 through 100
#
# Description:
# Print FizzBuzz for 1 through 100, choosing the label from the remainders.
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
#     Rscript fizzbuzz.R
#
# Requirements:
# - R 4.0 or later (Rscript)
# - No third-party package is required

label <- function(n) {
  if (n %% 15 == 0) {
    "FizzBuzz"
  } else if (n %% 3 == 0) {
    "Fizz"
  } else if (n %% 5 == 0) {
    "Buzz"
  } else {
    as.character(n)
  }
}

for (n in 1:100) {
  cat(label(n), "\n", sep = "")
}
