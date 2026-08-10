#!/usr/bin/env ruby
# Total the counts for each word.

class Reducer
  def self.reduce
    wordhash = {}
    $stdin.each_line do |line|
      word, count = line.strip.split
      if wordhash.has_key?(word)
        wordhash[word] += count.to_i
      else
        wordhash[word] = count.to_i
      end
    end
    wordhash.each {|record, count| puts "#{record}\t#{count}"}
  end
end

Reducer.reduce
