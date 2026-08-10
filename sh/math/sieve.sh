#!/bin/sh
# Print the primes below 100, striking out multiples from a list held in one string.
# POSIX shell has no array, so the sieve keeps its candidates as a space separated
# string and rebuilds it once per prime rather than clearing flags in place.

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
