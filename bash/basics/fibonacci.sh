#!/bin/bash
# Print the first 20 Fibonacci numbers, collected into an array.

current=0
next=1
values=()

for ((i = 0; i < 20; i++)); do
    values+=("$current")
    following=$((current + next))
    current=$next
    next=$following
done

echo "${values[*]}"
