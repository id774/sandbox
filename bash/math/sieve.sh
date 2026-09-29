#!/bin/bash
# sieve.sh: Primes below 100 by the sieve of Eratosthenes
#
# Description:
# Print the primes below 100, sieved over an array of flags indexed by the number itself.
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
#     bash sieve.sh
#
# Requirements:
# - Bash 4.0 or later
# - No third-party package is required

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
