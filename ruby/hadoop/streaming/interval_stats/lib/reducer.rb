#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-
# reducer.rb: Hadoop Streaming reducer for observed time spans
#
# Description:
# Report the observed time span of the keys seen at least eight times, reading
# sorted mapper output from standard input.
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
    key = newkey = json = ""
    times = []

    stdin.each_line {|line|
      newkey, timestamp, newjson = line.strip.split("\t")
      unless key == newkey
        if count >= 8
          total = times.max - times.min
          self.output(key, "start", times.min, 0, 0, json)
          self.output(key, "stop",  times.max, total, count, '{}',)
        end
        key = newkey
        json = newjson
        count = 0
        newkey = ""
        features = {}
        times = []
      end
      times.push(timestamp.to_i)
      count += 1
    }
    if count >= 8
      lines.each do |str|
        self.output(key, "start", times.min, 0, 0, json)
        self.output(key, "stop",  times.max, total, count, '{}',)
      end
    end
  end

  def self.output(key, type, timestamp, total, count, json)
    t = Time.at(timestamp.to_i).to_s
    puts "#{key}\t#{type}\t#{t}\t#{total}\t#{count}\t#{json}\n"
  end
end

if __FILE__ == $0
  Reducer.reduce($stdin)
end
