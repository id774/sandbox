# FizzBuzz.R: FizzBuzz with logical vector indexing
#
# Description:
# Print FizzBuzz for 1 through 100 by assigning Fizz, Buzz, and FizzBuzz
# through logical index vectors.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript FizzBuzz.R
#
# Requirements:
# - R
#

n <- 1:100
ans <- n

ans[n%%3==0 -> FizzSet] <- "Fizz"
ans[n%%5==0 -> BuzzSet] <- "Buzz"
 
ans[FizzSet & BuzzSet] <- "FizzBuzz"
 
cat(ans)

