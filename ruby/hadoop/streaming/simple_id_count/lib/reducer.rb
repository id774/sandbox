#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-

require 'json'

$:.unshift File.join(File.dirname(__FILE__))

class Reducer
  def self.reduce(stdin)
    count = 0
    key = newkey = ""

    stdin.each_line {|line|
      newkey, json = line.strip.split("\t")
      unless key == newkey
        puts "#{key}\t#{count}\n"
        key = newkey
        count = 0
        newkey = ""
      end
      count += 1
    }
    puts "#{key}\t#{count}\n" unless key == ""
  end
end

if __FILE__ == $0
  Reducer.reduce($stdin)
end
