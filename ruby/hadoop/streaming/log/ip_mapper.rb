#!/usr/bin/env ruby

class IPMapper
  def self.map
    $stdin.each_line do |line|
      word = line.split(" ")[10]
      puts "#{word}\t1"
    end
  end
end

IPMapper.map
