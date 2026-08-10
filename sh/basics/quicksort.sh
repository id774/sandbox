#!/bin/sh
# Sort a fixed list with a quicksort recursing over the positional parameters.
# POSIX shell has no local, so each recursive call is made inside a command
# substitution, whose subshell is what keeps the pivot of one call off another.

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
