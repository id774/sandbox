#!/bin/bash
# Print the divisor and multiple of fixed pairs, with Euclid's algorithm run in an arithmetic loop.

pairs=("1071 462" "270 192" "17 5" "120 36")

gcd() {
    local first=$1 second=$2 remainder
    while ((second != 0)); do
        remainder=$((first % second))
        first=$second
        second=$remainder
    done
    printf '%s\n' "$first"
}

for pair in "${pairs[@]}"; do
    read -r first second <<<"$pair"
    divisor=$(gcd "$first" "$second")
    printf '%d %d %d %d\n' "$first" "$second" "$divisor" "$((first / divisor * second))"
done
