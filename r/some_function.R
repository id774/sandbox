# some_function.R: Function returning two numbers and their sum
#
# Description:
# Define some_function, which returns its two arguments and their sum, and
# call it once. call_some_file.R sources this file.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript some_function.R
#
# Requirements:
# - R
#

some_function <- function (x, y) {
  return(c(x, y, x+y))
}

some_function(1, 2)
