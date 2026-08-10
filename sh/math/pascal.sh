#!/bin/sh
# Print 10 rows of Pascal's triangle, each row rebuilt as a string from the one before it.

rows=10

row=1
count=0
while [ "$count" -lt "$rows" ]; do
    echo "$row"

    previous=0
    next=
    for value in $row; do
        next="$next $((previous + value))"
        previous=$value
    done
    next="$next $previous"

    row=${next# }
    count=$((count + 1))
done
