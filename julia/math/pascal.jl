# pascal.jl: The first 10 rows of Pascal's triangle
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
#     julia pascal.jl
#
# Requirements:
# - Julia 1.4 or later
# - No third-party package is required

const ROWS = 10

row = [1]
for _ in 1:ROWS
    global row
    println(join(row, " "))
    row = [0; row] .+ [row; 0]
end
