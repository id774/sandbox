#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-
# powers.rb: Least product covering prime powers up to a limit
#
# Description:
# Find the least product covering the prime powers up to the limit given as an
# argument.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby powers.rb <limit>
#
# Requirements:
# - Ruby before 2.5, which still provides the mathn library
#

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
