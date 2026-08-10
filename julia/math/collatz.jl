# Print the start below 1000 with the longest Collatz sequence, picked by argmax over a range.
# Run: julia collatz.jl

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
