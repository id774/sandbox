# Count the words of a fixed text, most frequent first and alphabetically within a tie.
# Run: nim c -r word_frequency.nim

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
