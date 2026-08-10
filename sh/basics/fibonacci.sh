#!/bin/sh
# Print the first 20 Fibonacci numbers, accumulated into a space-separated string.
# POSIX shell has no array, so the values are collected in one variable.

current=0
next=1
values=
i=0

while [ "$i" -lt 20 ]; do
    values="$values $current"
    following=$((current + next))
    current=$next
    next=$following
    i=$((i + 1))
done

# Drop the leading space that the accumulation put there.
echo "${values# }"
