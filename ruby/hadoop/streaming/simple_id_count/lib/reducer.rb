#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-

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
