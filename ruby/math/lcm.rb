#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-

require 'mathn'

class Integer
  def lcm(other)
    big   = self.abs
    small = other.abs
    puts "#{big} #{small} "
    big, small = small, big if big < small
    product = big * small
    while small > 0
      tmp = small
      small = big % small
      big = tmp
    end
    return product / big
  end
end

#p,q = ARGV.shift.to_i,ARGV.shift.to_i
#puts p.lcm(q)

def least_product(num)
  m = 2
  2.upto(num) do |n|
    m = m.lcm(n)
  end
  return  m
end

num = ARGV.shift.to_i
puts least_product(num)
