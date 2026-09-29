#!/usr/bin/env python3
# word_frequency.py: Word frequencies of a fixed sentence
#
# Description:
# Count the words of a fixed text, most frequent first and alphabetically within a tie.
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
#     python3 word_frequency.py
#
# Requirements:
# - Python 3.10 or later
# - No third-party package is required

from collections import Counter

TEXT = "the quick brown fox jumps over the lazy dog the fox barks"

counts = Counter(TEXT.split())
for word, count in sorted(counts.items(), key=lambda pair: (-pair[1], pair[0])):
    print(f"{word} {count}")
