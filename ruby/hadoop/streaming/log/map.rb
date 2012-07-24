#!/usr/bin/env ruby

class Mapper
  def self.map
    $stdin.each_line do |line|
      word = line.split(" ")[10]
      puts "#{word}\t1"
    end
  end
end

Mapper.map
