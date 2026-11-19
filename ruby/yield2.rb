#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# yield2.rb: Enumerable#sum with an optional block
#
# Description:
# Add Enumerable#sum that optionally maps each element through a block.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby yield2.rb
#
# Requirements:
# - Ruby
#

module Enumerable
  def sum
    if block_given?
      inject(0) {|s, x| s + yield(x) }
    else
      inject(:+)
    end
  end
end

ary = [1, 5, 3]
p ary.sum # => 9
p ary.sum {|x| x * x} # => 35
