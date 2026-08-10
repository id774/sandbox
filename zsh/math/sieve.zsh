#!/bin/zsh
# Print the primes below 100, sieved over an array of flags.
# zsh arrays index from 1, so the flag for n sits at position n + 1.

limit=100

is_prime=()
for ((n = 0; n < limit; n++)); do
    is_prime[n + 1]=$((n >= 2))
done

for ((n = 2; n * n < limit; n++)); do
    ((is_prime[n + 1])) || continue
    for ((multiple = n * n; multiple < limit; multiple += n)); do
        is_prime[multiple + 1]=0
    done
done

primes=()
for ((n = 0; n < limit; n++)); do
    ((is_prime[n + 1])) && primes+=($n)
done

print -- $primes
