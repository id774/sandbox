#!/usr/bin/env ruby
# Emit each word of the input with a count of one.

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
