#!/bin/bash
# Multiply two fixed 3x3 integer matrices flattened into one indexed array each.
# Bash has no array of arrays, so the row and column reach the entry through the
# arithmetic index (row * size + column) rather than through two subscripts.

size=3
left=(2 -1 0 1 3 4 0 5 -2)
right=(1 0 2 -3 1 1 4 2 0)

product=()
for ((i = 0; i < size; i++)); do
    row=()
    for ((j = 0; j < size; j++)); do
        sum=0
        for ((k = 0; k < size; k++)); do
            ((sum += left[i * size + k] * right[k * size + j]))
        done
        product[i * size + j]=$sum
        row+=("$sum")
    done
    printf '%s\n' "${row[*]}"
done

printf '%d\n' "$((product[0] * (product[4] * product[8] - product[5] * product[7])
                - product[1] * (product[3] * product[8] - product[5] * product[6])
                + product[2] * (product[3] * product[7] - product[4] * product[6])))"
