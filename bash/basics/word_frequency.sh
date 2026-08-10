#!/bin/bash
# Count the words of a fixed text, most frequent first and alphabetically within a tie.
# The counts live in an associative array, which is the reason this one needs Bash.

text="the quick brown fox jumps over the lazy dog the fox barks"

declare -A counts
for word in $text; do
    counts["$word"]=$((${counts["$word"]:-0} + 1))
done

for word in "${!counts[@]}"; do
    printf '%s %s\n' "$word" "${counts[$word]}"
done | LC_ALL=C sort -k2,2nr -k1,1
