#!/usr/bin/env ruby
# Emit the eleventh field of each log line as a key.

class Mapper
  def self.map
    $stdin.each_line do |line|
      word = line.split(" ")[10]
      puts "#{word}\t1"
    end
  end
end

Mapper.map
