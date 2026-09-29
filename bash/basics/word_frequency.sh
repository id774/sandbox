#!/bin/bash
# word_frequency.sh: Word frequencies of a fixed sentence
#
# Description:
# Count the words of a fixed text, most frequent first and alphabetically within a tie.
# The counts live in an associative array, which is the reason this one needs Bash.
#
# Part of the basics cross-language exercise set: the input is fixed in the
# source, and the output is the same as that of the same exercise in every
# other language. The exercises are specified in README.md at the
# repository root.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     bash word_frequency.sh
#
# Requirements:
# - Bash 4.0 or later
# - The POSIX sort utility
# - No third-party package is required

text="the quick brown fox jumps over the lazy dog the fox barks"

declare -A counts
for word in $text; do
    counts["$word"]=$((${counts["$word"]:-0} + 1))
done

for word in "${!counts[@]}"; do
    printf '%s %s\n' "$word" "${counts[$word]}"
done | LC_ALL=C sort -k2,2nr -k1,1
