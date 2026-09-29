#!/bin/zsh
# collatz.zsh: Longest Collatz sequence for a start below 1000
#
# Description:
# Print the start below 1000 with the longest Collatz sequence, tracked in a running maximum.
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
#     zsh collatz.zsh
#
# Requirements:
# - Zsh 5.0 or later
# - No third-party package is required

limit=1000

chain_length() {
    local value=$1 length=1
    while ((value != 1)); do
        ((value = value % 2 == 0 ? value / 2 : value * 3 + 1))
        ((length++))
    done
    print -- $length
}

longest=1
best=1

for ((start = 1; start < limit; start++)); do
    length=$(chain_length $start)
    if ((length > best)); then
        longest=$start
        best=$length
    fi
done

print -- $longest $best
