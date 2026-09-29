#!/bin/sh
# collatz.sh: Longest Collatz sequence for a start below 1000
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
#     sh collatz.sh
#
# Requirements:
# - A POSIX.1-2008 sh, such as dash 0.5 or later
# - No third-party package is required

limit=1000

longest=1
best=1

start=1
while [ "$start" -lt "$limit" ]; do
    value=$start
    length=1
    while [ "$value" -ne 1 ]; do
        if [ $((value % 2)) -eq 0 ]; then
            value=$((value / 2))
        else
            value=$((value * 3 + 1))
        fi
        length=$((length + 1))
    done

    if [ "$length" -gt "$best" ]; then
        longest=$start
        best=$length
    fi
    start=$((start + 1))
done

echo "$longest $best"
