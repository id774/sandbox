# collatz.jl: Longest Collatz sequence for a start below 1000
#
# Description:
# Print the start below 1000 with the longest Collatz sequence, picked by argmax over a range.
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
#     julia collatz.jl
#
# Requirements:
# - Julia 1.4 or later
# - No third-party package is required

const LIMIT = 1000

function chain_length(start)
    value = start
    length = 1
    while value != 1
        value = iseven(value) ? value ÷ 2 : value * 3 + 1
        length += 1
    end
    return length
end

starts = 1:(LIMIT - 1)
longest = starts[argmax(chain_length.(starts))]
println(longest, " ", chain_length(longest))
