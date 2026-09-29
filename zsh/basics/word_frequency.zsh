#!/bin/zsh
# word_frequency.zsh: Word frequencies of a fixed sentence
#
# Description:
# Count the words of a fixed text, most frequent first and alphabetically within a tie.
# ${=text} splits on whitespace, which zsh does not do to an expansion by default,
# and ${(k)counts} expands the keys of an associative array.
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
#     zsh word_frequency.zsh
#
# Requirements:
# - Zsh 5.0 or later
# - The POSIX sort utility
# - No third-party package is required

typeset text="the quick brown fox jumps over the lazy dog the fox barks"
typeset -A counts
typeset word

for word in ${=text}; do
    counts[$word]=$((${counts[$word]:-0} + 1))
done

for word in ${(k)counts}; do
    print -- "$word $counts[$word]"
done | LC_ALL=C sort -k2,2nr -k1,1
