#!/usr/bin/env ruby
# map.rb: Hadoop Streaming word count mapper
#
# Description:
# Emit each word of standard input with a count of one.
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

class Mapper
  def self.map
    $stdin.each_line do |line|
      line.split.each do |word|
        puts "#{word}\t1"
      end
    end
  end
end

Mapper.map
