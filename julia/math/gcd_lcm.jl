# Print the divisor and multiple of fixed pairs, with Euclid's algorithm written out rather than taken from Base.
# Run: julia gcd_lcm.jl

const PAIRS = [(1071, 462), (270, 192), (17, 5), (120, 36)]

function euclid(first, second)
    while second != 0
        first, second = second, first % second
    end
    return first
end

for (first, second) in PAIRS
    divisor = euclid(first, second)
    println(join((first, second, divisor, first ÷ divisor * second), " "))
end
