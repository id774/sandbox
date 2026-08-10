# Print the first 20 Fibonacci numbers, filled into a preallocated vector.
# Run: julia fibonacci.jl

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
