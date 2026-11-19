#!/usr/bin/env ruby
# reduce.rb: Hadoop Streaming word count reducer
#
# Description:
# Total the counts for each word from sorted standard input.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     cat data.txt | ruby map.rb | sort | ruby reduce.rb
#
# Requirements:
# - Ruby
#

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
