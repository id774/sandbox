#!/bin/sh
# gcd_lcm.sh: GCD and LCM of fixed pairs by Euclid's algorithm
#
# Description:
# Print the divisor and multiple of fixed pairs, with Euclid's algorithm run in a while loop.
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
#     sh gcd_lcm.sh
#
# Requirements:
# - A POSIX.1-2008 sh, such as dash 0.5 or later
# - No third-party package is required

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
