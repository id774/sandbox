#!/bin/sh
# quicksort.sh: Quicksort of a fixed integer sequence
#
# Description:
# Sort a fixed list with a quicksort recursing over the positional parameters.
# POSIX shell has no local, so each recursive call is made inside a command
# substitution, whose subshell is what keeps the pivot of one call off another.
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
#     sh quicksort.sh
#
# Requirements:
# - A POSIX.1-2008 sh, such as dash 0.5 or later
# - No third-party package is required

quicksort() {
    if [ "$#" -le 1 ]; then
        echo "$*"
        return
    fi

    pivot=$1
    shift

    smaller=
    larger=
    for value in "$@"; do
        if [ "$value" -le "$pivot" ]; then
            smaller="$smaller $value"
        else
            larger="$larger $value"
        fi
    done

    # Unquoted on purpose: the collected strings split back into arguments, and
    # a side that came out empty contributes none.
    set -- $(quicksort $smaller) "$pivot" $(quicksort $larger)
    echo "$*"
}

quicksort 5 3 8 4 2 7 1 10 9 6
