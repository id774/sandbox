#!/usr/bin/env ruby
# Count the words of a fixed text, most frequent first and alphabetically within a tie.

TEXT = 'the quick brown fox jumps over the lazy dog the fox barks'

TEXT.split.tally.sort_by { |word, count| [-count, word] }.each do |word, count|
  puts "#{word} #{count}"
end
