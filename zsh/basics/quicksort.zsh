#!/bin/zsh
# quicksort.zsh: Quicksort of a fixed integer sequence
#
# Description:
# Sort a fixed list with a quicksort over zsh arrays.
# zsh arrays index from 1, and $items[2,-1] slices from the second element on.
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
#     zsh quicksort.zsh
#
# Requirements:
# - Zsh 5.0 or later
# - No third-party package is required

quicksort() {
    local -a items=($@)
    (($#items <= 1)) && { print -- $items; return }

    local pivot=$items[1]
    local -a rest=($items[2,-1]) smaller larger
    local value

    for value in $rest; do
        if ((value <= pivot)); then
            smaller+=($value)
        else
            larger+=($value)
        fi
    done

    local -a left=($(quicksort $smaller)) right=($(quicksort $larger))
    print -- $left $pivot $right
}

quicksort 5 3 8 4 2 7 1 10 9 6
