# quicksort.jl: Quicksort of a fixed integer sequence
#
# Description:
# Sort a fixed vector with a quicksort generic over any ordered element type.
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
#     julia quicksort.jl
#
# Requirements:
# - Julia 1.4 or later
# - No third-party package is required

function quicksort(items::AbstractVector{T}) where {T}
    length(items) <= 1 && return collect(items)
    pivot = items[begin]
    rest = @view items[(begin + 1):end]
    return vcat(quicksort(filter(x -> x <= pivot, rest)),
                pivot,
                quicksort(filter(x -> x > pivot, rest)))
end

println(join(quicksort([5, 3, 8, 4, 2, 7, 1, 10, 9, 6]), " "))
