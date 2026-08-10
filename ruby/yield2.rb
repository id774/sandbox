#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# Add Enumerable#sum that optionally maps each element through a block.

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
