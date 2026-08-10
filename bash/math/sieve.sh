#!/bin/bash
# Print the primes below 100, sieved over an array of flags indexed by the number itself.

limit=100

is_prime=()
for ((n = 0; n < limit; n++)); do
    is_prime[n]=$((n >= 2))
done

for ((n = 2; n * n < limit; n++)); do
    ((is_prime[n])) || continue
    for ((multiple = n * n; multiple < limit; multiple += n)); do
        is_prime[multiple]=0
    done
done

primes=()
for ((n = 0; n < limit; n++)); do
    ((is_prime[n])) && primes+=("$n")
done

printf '%s\n' "${primes[*]}"
