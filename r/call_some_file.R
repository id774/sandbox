# call_some_file.R: Call a function defined in another file
#
# Description:
# Load some_function.R with source and call some_function with three pairs of
# arguments.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript call_some_file.R
#
# Requirements:
# - R
# - Run from this directory, which holds some_function.R
#

source("some_function.R")

some_function(3, 4)
some_function(5, 6)
some_function(7, 8)
