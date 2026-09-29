# sieve.jl: Primes below 100 by the sieve of Eratosthenes
#
# Description:
# Print the primes below 100, sieved over a BitVector indexed by the number itself.
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
#     julia sieve.jl
#
# Requirements:
# - Julia 1.4 or later
# - No third-party package is required

const LIMIT = 100

is_prime = trues(LIMIT)
is_prime[1] = false

for n in 2:isqrt(LIMIT)
    if is_prime[n]
        is_prime[(n * n):n:LIMIT] .= false
    end
end

println(join(findall(is_prime), " "))
