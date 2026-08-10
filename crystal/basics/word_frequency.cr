# Count the words of a fixed text, most frequent first and alphabetically within a tie.
# Run: crystal run word_frequency.cr

TEXT = "the quick brown fox jumps over the lazy dog the fox barks"

counts = Hash(String, Int32).new(0)
TEXT.split.each { |word| counts[word] += 1 }

counts.to_a.sort_by { |(word, count)| {-count, word} }.each do |(word, count)|
  puts "#{word} #{count}"
end
