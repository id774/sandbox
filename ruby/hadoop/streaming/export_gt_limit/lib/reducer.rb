#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-
# reducer.rb: Hadoop Streaming reducer keeping frequent keys
#
# Description:
# Keep only the keys that were seen at least eight times, reading sorted
# mapper output from standard input.
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
    lines = []

    stdin.each_line {|line|
      newkey, json = line.strip.split("\t")
      unless key == newkey
        if count >= 8
          lines.each do |str|
            self.output(str, count)
          end
        end
        key = newkey
        count = 0
        newkey = ""
        lines = []
      end
      lines.push(line)
      count += 1
    }
    if count >= 8
      lines.each do |str|
        self.output(str, count)
      end
    end
  end

  def self.output(line, count)
    key, json = line.strip.split("\t")
    hash = JSON.parse(json)
    hash['count'] = count
    new_json = JSON.generate(hash)
    puts "#{new_json}\n"
  end
end

if __FILE__ == $0
  Reducer.reduce($stdin)
end
