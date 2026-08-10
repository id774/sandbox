#!/bin/zsh
# Print 10 rows of Pascal's triangle, each row rewritten in place from its right hand end.

rows=10

row=(1)
for ((length = 1; length <= rows; length++)); do
    print -- $row

    row+=(0)
    for ((i = length + 1; i > 1; i--)); do
        ((row[i] += row[i - 1]))
    done
done
