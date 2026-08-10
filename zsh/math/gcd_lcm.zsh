#!/bin/zsh
# Print the divisor and multiple of fixed pairs, split back into fields with ${=pair}.

pairs=("1071 462" "270 192" "17 5" "120 36")

gcd() {
    local first=$1 second=$2 remainder
    while ((second != 0)); do
        remainder=$((first % second))
        first=$second
        second=$remainder
    done
    print -- $first
}

for pair in $pairs; do
    values=(${=pair})
    first=$values[1]
    second=$values[2]
    divisor=$(gcd $first $second)
    print -- $first $second $divisor $((first / divisor * second))
done
