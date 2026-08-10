#!/bin/sh
# Count the words of a fixed text, most frequent first and alphabetically within a tie.
# POSIX shell has no associative array, so the counting is left to sort and uniq.

text="the quick brown fox jumps over the lazy dog the fox barks"

# One word per line, so that uniq -c can count runs of equal lines.
printf '%s\n' $text |
    LC_ALL=C sort |
    uniq -c |
    LC_ALL=C sort -k1,1nr -k2,2 |
    while read -r count word; do
        printf '%s %s\n' "$word" "$count"
    done
