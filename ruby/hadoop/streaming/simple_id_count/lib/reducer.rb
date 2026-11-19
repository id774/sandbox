#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-
# reducer.rb: Hadoop Streaming reducer totaling counts per key
#
# Description:
# Total the counts for each key from sorted standard input.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     cat <input> | ruby lib/mapper.rb | sort | ruby lib/reducer.rb
#
# Requirements:
# - Ruby
#

require 'json'

$:.unshift File.join(File.dirname(__FILE__))

class Reducer
  def self.reduce(stdin)
    count = 0
    key = newkey = ""

    stdin.each_line {|line|
      newkey, num = line.strip.split("\t")
      unless key == newkey
        puts "#{key}\t#{count}\n" if count > 0
        key = newkey
        count = 0
        newkey = ""
      end
      count += num.to_i
    }
    puts "#{key}\t#{count}\n" if count > 0
  end
end

if __FILE__ == $0
  Reducer.reduce($stdin)
end
