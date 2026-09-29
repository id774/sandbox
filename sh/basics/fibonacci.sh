#!/bin/sh
# fibonacci.sh: The first 20 Fibonacci numbers
#
# Description:
# Print the first 20 Fibonacci numbers, accumulated into a space-separated string.
# POSIX shell has no array, so the values are collected in one variable.
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
#     sh fibonacci.sh
#
# Requirements:
# - A POSIX.1-2008 sh, such as dash 0.5 or later
# - No third-party package is required

current=0
next=1
values=
i=0

while [ "$i" -lt 20 ]; do
    values="$values $current"
    following=$((current + next))
    current=$next
    next=$following
    i=$((i + 1))
done

# Drop the leading space that the accumulation put there.
echo "${values# }"
