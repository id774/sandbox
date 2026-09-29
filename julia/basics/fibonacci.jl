# fibonacci.jl: The first 20 Fibonacci numbers
#
# Description:
# Print the first 20 Fibonacci numbers, filled into a preallocated vector.
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
#     julia fibonacci.jl
#
# Requirements:
# - Julia 1.4 or later
# - No third-party package is required

function fibonacci(count::Integer)
    values = Vector{Int}(undef, count)
    current, next = 0, 1
    for i in 1:count
        values[i] = current
        current, next = next, current + next
    end
    return values
end

println(join(fibonacci(20), " "))
