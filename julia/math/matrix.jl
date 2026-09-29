# matrix.jl: Product and determinant of two fixed 3x3 integer matrices
#
# Description:
# Multiply two fixed 3x3 integer matrices, written out rather than left to the * of Base.
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
#     julia matrix.jl
#
# Requirements:
# - Julia 1.4 or later
# - No third-party package is required

const LEFT = [2 -1 0; 1 3 4; 0 5 -2]
const RIGHT = [1 0 2; -3 1 1; 4 2 0]

function multiply(a, b)
    rows, inner = size(a)
    columns = size(b, 2)
    product = zeros(Int, rows, columns)
    for i in 1:rows, j in 1:columns, k in 1:inner
        product[i, j] += a[i, k] * b[k, j]
    end
    return product
end

function determinant(m)
    return m[1, 1] * (m[2, 2] * m[3, 3] - m[2, 3] * m[3, 2]) -
           m[1, 2] * (m[2, 1] * m[3, 3] - m[2, 3] * m[3, 1]) +
           m[1, 3] * (m[2, 1] * m[3, 2] - m[2, 2] * m[3, 1])
end

product = multiply(LEFT, RIGHT)

for i in 1:size(product, 1)
    println(join(product[i, :], " "))
end
println(determinant(product))
