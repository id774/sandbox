#!/bin/sh
# pascal.sh: The first 10 rows of Pascal's triangle
#
# Description:
# Print 10 rows of Pascal's triangle, each row rebuilt as a string from the one before it.
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
#     sh pascal.sh
#
# Requirements:
# - A POSIX.1-2008 sh, such as dash 0.5 or later
# - No third-party package is required

rows=10

row=1
count=0
while [ "$count" -lt "$rows" ]; do
    echo "$row"

    previous=0
    next=
    for value in $row; do
        next="$next $((previous + value))"
        previous=$value
    done
    next="$next $previous"

    row=${next# }
    count=$((count + 1))
done
