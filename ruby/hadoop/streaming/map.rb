#!/usr/bin/env ruby

# Our input comes from STDIN
STDIN.each_line do |line|

  # Iterate over the line, splitting the words from the line and emitting
  # as the word with a count of 1.
  line.split.each do |word|
    puts "#{word}\t1"
  end

end
