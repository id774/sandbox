#!/bin/bash
# Print the start below 1000 with the longest Collatz sequence, tracked in a running maximum.

limit=1000

chain_length() {
    local value=$1 length=1
    while ((value != 1)); do
        ((value = value % 2 == 0 ? value / 2 : value * 3 + 1))
        ((length++))
    done
    printf '%s\n' "$length"
}

longest=1
best=1

for ((start = 1; start < limit; start++)); do
    length=$(chain_length "$start")
    if ((length > best)); then
        longest=$start
        best=$length
    fi
done

printf '%d %d\n' "$longest" "$best"
