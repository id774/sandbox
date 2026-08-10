#!/bin/zsh
# Count the words of a fixed text, most frequent first and alphabetically within a tie.
# ${=text} splits on whitespace, which zsh does not do to an expansion by default,
# and ${(k)counts} expands the keys of an associative array.

typeset text="the quick brown fox jumps over the lazy dog the fox barks"
typeset -A counts
typeset word

for word in ${=text}; do
    counts[$word]=$((${counts[$word]:-0} + 1))
done

for word in ${(k)counts}; do
    print -- "$word $counts[$word]"
done | LC_ALL=C sort -k2,2nr -k1,1
