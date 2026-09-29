#!/bin/bash
# quicksort.sh: Quicksort of a fixed integer sequence
#
# Description:
# Sort a fixed list with a quicksort recursing over the positional parameters.
# Bash gives each call its own pivot and partitions through local.
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
#     bash quicksort.sh
#
# Requirements:
# - Bash 4.0 or later
# - No third-party package is required

quicksort() {
    if (($# <= 1)); then
        printf '%s\n' "$*"
        return
    fi

    local pivot=$1
    shift

    local smaller=() larger=() value
    for value in "$@"; do
        if ((value <= pivot)); then
            smaller+=("$value")
        else
            larger+=("$value")
        fi
    done

    local head tail parts=()
    head=$(quicksort ${smaller[@]+"${smaller[@]}"})
    tail=$(quicksort ${larger[@]+"${larger[@]}"})
    [[ -n $head ]] && parts+=("$head")
    parts+=("$pivot")
    [[ -n $tail ]] && parts+=("$tail")
    printf '%s\n' "${parts[*]}"
}

quicksort 5 3 8 4 2 7 1 10 9 6
