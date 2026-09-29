# word_frequency.nim: Word frequencies of a fixed sentence
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
#     nim c -r word_frequency.nim
#
# Requirements:
# - Nim 1.6 or later, with a C compiler for its default C backend
# - No third-party package is required

import std/[algorithm, sequtils, strutils, tables]

const text = "the quick brown fox jumps over the lazy dog the fox barks"

var counts = initCountTable[string]()
for word in text.splitWhitespace():
  counts.inc(word)

var ranked = toSeq(counts.pairs)
ranked.sort(proc (a, b: (string, int)): int =
  if a[1] != b[1]: cmp(b[1], a[1]) else: cmp(a[0], b[0]))

for (word, count) in ranked:
  echo word, " ", count
