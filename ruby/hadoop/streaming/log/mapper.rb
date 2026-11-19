#!/usr/bin/env ruby
# mapper.rb: Hadoop Streaming mapper for the eleventh log field
#
# Description:
# Emit the eleventh field of each log line from standard input as a key.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     cat data.txt | ruby mapper.rb | sort | ruby reducer.rb
#
# Requirements:
# - Ruby
#

class Mapper
  def self.map
    $stdin.each_line do |line|
      word = line.split(" ")[10]
      puts "#{word}\t1"
    end
  end
end

Mapper.map
