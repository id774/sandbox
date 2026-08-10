#!/bin/zsh
# Print the first 20 Fibonacci numbers, collected into an array.
# repeat is a zsh loop, and print joins an array with spaces on its own.

typeset -a values
typeset -i current=0 next=1 following

repeat 20; do
    values+=($current)
    following=$((current + next))
    current=$next
    next=$following
done

print $values
