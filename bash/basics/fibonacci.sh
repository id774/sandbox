#!/bin/bash
# fibonacci.sh: The first 20 Fibonacci numbers
#
# Description:
# Print the first 20 Fibonacci numbers, collected into an array.
#
# Part of the basics cross-language exercise set: the input is fixed in the
# source, and the output is the same as that of the same exercise in every
# other language. The exercises are specified in README.md at the
# repository root.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     bash fibonacci.sh
#
# Requirements:
# - Bash 4.0 or later
# - No third-party package is required

current=0
next=1
values=()

for ((i = 0; i < 20; i++)); do
    values+=("$current")
    following=$((current + next))
    current=$next
    next=$following
done

echo "${values[*]}"
