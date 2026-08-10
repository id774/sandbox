#!/usr/bin/env python3
# Count the words of a fixed text, most frequent first and alphabetically within a tie.

from collections import Counter

TEXT = "the quick brown fox jumps over the lazy dog the fox barks"

counts = Counter(TEXT.split())
for word, count in sorted(counts.items(), key=lambda pair: (-pair[1], pair[0])):
    print(f"{word} {count}")
