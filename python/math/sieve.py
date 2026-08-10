#!/usr/bin/env python3
# Print the primes below 100, sieved by striking out multiples with slice assignment.

LIMIT = 100

is_prime = [True] * LIMIT
is_prime[0] = is_prime[1] = False

for n in range(2, int(LIMIT ** 0.5) + 1):
    if is_prime[n]:
        multiples = is_prime[n * n::n]
        is_prime[n * n::n] = [False] * len(multiples)

print(" ".join(str(n) for n, prime in enumerate(is_prime) if prime))
