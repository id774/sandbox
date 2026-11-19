# closure.R: Counter closure with the <<- operator
#
# Description:
# Build a counter closure that updates an enclosing variable with <<- and show
# that a global variable of the same name is unaffected.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript closure.R
#
# Requirements:
# - R
#

func <- function() {
  x <- 0
  function() {
    x <<- x + 1
    return (x)
  }
}

x <- 10

closure <- func()

print(x)
print(closure())
print(closure())
print(closure())
print(closure())
print(x)

