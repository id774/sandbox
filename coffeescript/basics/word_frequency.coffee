# Count the words of a fixed text, most frequent first and alphabetically within a tie.
# Run: coffee word_frequency.coffee

text = 'the quick brown fox jumps over the lazy dog the fox barks'

counts = {}
counts[word] = (counts[word] ? 0) + 1 for word in text.split /\s+/

ranked = ([word, count] for word, count of counts)
ranked.sort (a, b) ->
  b[1] - a[1] or (if a[0] < b[0] then -1 else if a[0] > b[0] then 1 else 0)

for [word, count] in ranked
  console.log "#{word} #{count}"
