#!/usr/bin/env ruby

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
