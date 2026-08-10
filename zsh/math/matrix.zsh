#!/bin/zsh
# Multiply two fixed 3x3 integer matrices flattened into one array each.
# zsh indexes from 1, so the entry at row i and column j sits at size * (i - 1) + j.
# The multiplication leads because a subscript opening with a parenthesis is read
# as a subscript flag rather than as arithmetic.

size=3
left=(2 -1 0 1 3 4 0 5 -2)
right=(1 0 2 -3 1 1 4 2 0)

product=()
for ((i = 1; i <= size; i++)); do
    row=()
    for ((j = 1; j <= size; j++)); do
        sum=0
        for ((k = 1; k <= size; k++)); do
            ((sum += left[size * (i - 1) + k] * right[size * (k - 1) + j]))
        done
        product[size * (i - 1) + j]=$sum
        row+=($sum)
    done
    print -- $row
done

print -- $((product[1] * (product[5] * product[9] - product[6] * product[8])
          - product[2] * (product[4] * product[9] - product[6] * product[7])
          + product[3] * (product[4] * product[8] - product[5] * product[7])))
