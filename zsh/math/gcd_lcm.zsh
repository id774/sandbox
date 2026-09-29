#!/bin/zsh
# gcd_lcm.zsh: GCD and LCM of fixed pairs by Euclid's algorithm
#
# Description:
# Print the divisor and multiple of fixed pairs, split back into fields with ${=pair}.
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
#     zsh gcd_lcm.zsh
#
# Requirements:
# - Zsh 5.0 or later
# - No third-party package is required

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
