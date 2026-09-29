#!/bin/sh
# sieve.sh: Primes below 100 by the sieve of Eratosthenes
#
# Description:
# Print the primes below 100, striking out multiples from a list held in one string.
# POSIX shell has no array, so the sieve keeps its candidates as a space separated
# string and rebuilds it once per prime rather than clearing flags in place.
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
#     sh sieve.sh
#
# Requirements:
# - A POSIX.1-2008 sh, such as dash 0.5 or later
# - No third-party package is required

limit=100

candidates=
n=2
while [ "$n" -lt "$limit" ]; do
    candidates="$candidates $n"
    n=$((n + 1))
done

primes=
while set -- $candidates; [ "$#" -gt 0 ]; do
    prime=$1
    primes="$primes $prime"

    remaining=
    for value in "$@"; do
        if [ $((value % prime)) -ne 0 ]; then
            remaining="$remaining $value"
        fi
    done
    candidates=$remaining
done

echo "${primes# }"
