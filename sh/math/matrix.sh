#!/bin/sh
# Multiply two fixed 3x3 integer matrices addressed through eval built variable names.
# POSIX shell has no array, so each entry is its own variable and the row and
# column indices are pasted into the name rather than used as a subscript.

size=3

store() {
    prefix=$1
    shift
    index=1
    for value in "$@"; do
        eval "$prefix$index=$value"
        index=$((index + 1))
    done
}

load() {
    eval "echo \$$1$(( ($2 - 1) * size + $3 ))"
}

store left 2 -1 0 1 3 4 0 5 -2
store right 1 0 2 -3 1 1 4 2 0

row_index=1
while [ "$row_index" -le "$size" ]; do
    column_index=1
    row=
    while [ "$column_index" -le "$size" ]; do
        sum=0
        k=1
        while [ "$k" -le "$size" ]; do
            sum=$((sum + $(load left "$row_index" "$k") * $(load right "$k" "$column_index")))
            k=$((k + 1))
        done
        eval "product$(( (row_index - 1) * size + column_index ))=$sum"
        row="$row $sum"
        column_index=$((column_index + 1))
    done
    echo "${row# }"
    row_index=$((row_index + 1))
done

echo $((product1 * (product5 * product9 - product6 * product8)
      - product2 * (product4 * product9 - product6 * product7)
      + product3 * (product4 * product8 - product5 * product7)))
