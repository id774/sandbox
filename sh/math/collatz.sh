#!/bin/sh
# Print the start below 1000 with the longest Collatz sequence, tracked in a running maximum.

limit=1000

longest=1
best=1

start=1
while [ "$start" -lt "$limit" ]; do
    value=$start
    length=1
    while [ "$value" -ne 1 ]; do
        if [ $((value % 2)) -eq 0 ]; then
            value=$((value / 2))
        else
            value=$((value * 3 + 1))
        fi
        length=$((length + 1))
    done

    if [ "$length" -gt "$best" ]; then
        longest=$start
        best=$length
    fi
    start=$((start + 1))
done

echo "$longest $best"
