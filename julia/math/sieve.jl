# Print the primes below 100, sieved over a BitVector indexed by the number itself.
# Run: julia sieve.jl

const LIMIT = 100

is_prime = trues(LIMIT)
is_prime[1] = false

for n in 2:isqrt(LIMIT)
    if is_prime[n]
        is_prime[(n * n):n:LIMIT] .= false
    end
end

println(join(findall(is_prime), " "))
