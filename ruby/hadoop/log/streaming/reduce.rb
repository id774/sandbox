#!/usr/bin/env ruby

# Create an empty word hash
wordhash = {}

# Our input comes from STDIN, operating on each line
STDIN.each_line do |line|

  # Each line will represent a word and count
  word, count = line.strip.split

  # If we have the word in the hash, add the count to it, otherwise
  # create a new one.
  if wordhash.has_key?(word)
    wordhash[word] += count.to_i
  else
    wordhash[word] = count.to_i
  end

end

# Iterate through and emit the word counters
wordhash.each {|record, count| puts "#{record}\t#{count}"}
