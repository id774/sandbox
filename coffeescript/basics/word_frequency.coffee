# word_frequency.coffee: Word frequencies of a fixed sentence
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
#     coffee word_frequency.coffee
#
# Requirements:
# - CoffeeScript 2.0 or later (coffee)
# - Node.js 20 or later
# - No third-party package is required

text = 'the quick brown fox jumps over the lazy dog the fox barks'

counts = {}
counts[word] = (counts[word] ? 0) + 1 for word in text.split /\s+/

ranked = ([word, count] for word, count of counts)
ranked.sort (a, b) ->
  b[1] - a[1] or (if a[0] < b[0] then -1 else if a[0] > b[0] then 1 else 0)

for [word, count] in ranked
  console.log "#{word} #{count}"
