#!/bin/bash
# pascal.sh: The first 10 rows of Pascal's triangle
#
# Description:
# Print 10 rows of Pascal's triangle, each row rewritten in place from its right hand end.
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
#     bash pascal.sh
#
# Requirements:
# - Bash 4.0 or later
# - No third-party package is required

rows=10

row=(1)
for ((length = 1; length <= rows; length++)); do
    printf '%s\n' "${row[*]}"

    row+=(0)
    for ((i = length; i > 0; i--)); do
        ((row[i] += row[i - 1]))
    done
done
