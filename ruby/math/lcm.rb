#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-
# lcm.rb: Least common multiple computed by hand
#
# Description:
# Compute the least common multiple by hand, and print the least common
# multiple of the integers from 2 through the number given as an argument.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby lcm.rb <number>
#
# Requirements:
# - Ruby before 2.5, which still provides the mathn library
#

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
