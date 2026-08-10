#!/bin/sh
# Print the divisor and multiple of fixed pairs, with Euclid's algorithm run in a while loop.

gcd() {
    first=$1
    second=$2
    while [ "$second" -ne 0 ]; do
        remainder=$((first % second))
        first=$second
        second=$remainder
    done
    echo "$first"
}

for pair in 1071:462 270:192 17:5 120:36; do
    first=${pair%:*}
    second=${pair#*:}
    divisor=$(gcd "$first" "$second")
    echo "$first $second $divisor $((first / divisor * second))"
done
