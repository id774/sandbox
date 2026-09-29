#!/bin/sh
# word_frequency.sh: Word frequencies of a fixed sentence
#
# Description:
# Count the words of a fixed text, most frequent first and alphabetically within a tie.
# POSIX shell has no associative array, so the counting is left to sort and uniq.
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
#     sh word_frequency.sh
#
# Requirements:
# - A POSIX.1-2008 sh, such as dash 0.5 or later
# - The POSIX sort and uniq utilities
# - No third-party package is required

text="the quick brown fox jumps over the lazy dog the fox barks"

# One word per line, so that uniq -c can count runs of equal lines.
printf '%s\n' $text |
    LC_ALL=C sort |
    uniq -c |
    LC_ALL=C sort -k1,1nr -k2,2 |
    while read -r count word; do
        printf '%s %s\n' "$word" "$count"
    done
