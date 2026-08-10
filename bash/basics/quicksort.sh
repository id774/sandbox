#!/bin/bash
# Sort a fixed list with a quicksort recursing over the positional parameters.
# Bash gives each call its own pivot and partitions through local.

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
