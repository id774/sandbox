# Multiply two fixed 3x3 integer matrices, written out rather than left to the * of Base.
# Run: julia matrix.jl

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
