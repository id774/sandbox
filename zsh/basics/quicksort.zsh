#!/bin/zsh
# Sort a fixed list with a quicksort over zsh arrays.
# zsh arrays index from 1, and $items[2,-1] slices from the second element on.

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
