#!/bin/zsh
# sieve.zsh: Primes below 100 by the sieve of Eratosthenes
#
# Description:
# Print the primes below 100, sieved over an array of flags.
# zsh arrays index from 1, so the flag for n sits at position n + 1.
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
#     zsh sieve.zsh
#
# Requirements:
# - Zsh 5.0 or later
# - No third-party package is required

limit=100

is_prime=()
# An assignment subscript takes no spaces: zsh would end the word at the first one.
for ((n = 0; n < limit; n++)); do
    is_prime[n+1]=$((n >= 2))
done

for ((n = 2; n * n < limit; n++)); do
    ((is_prime[n + 1])) || continue
    for ((multiple = n * n; multiple < limit; multiple += n)); do
        is_prime[multiple+1]=0
    done
done

primes=()
for ((n = 0; n < limit; n++)); do
    ((is_prime[n + 1])) && primes+=($n)
done

print -- $primes
