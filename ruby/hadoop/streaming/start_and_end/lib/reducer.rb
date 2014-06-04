#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-

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
