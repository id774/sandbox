#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-

require 'mathn'
def least_product(num)
  powers = Hash.new{0}
  2.upto(num){|n|
    pw = n.prime_division
    pw.each{|i,j|
      powers[i] = j if j > powers[i]
    }
  }
  powers.inject(1){|r,a| r * (a[0] ** a[1])}
end

num = ARGV.shift.to_i
puts least_product(num)
