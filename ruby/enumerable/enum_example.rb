#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# enum_example.rb: Enumerable methods from include and each
#
# Description:
# Gain the Enumerable methods by including it and defining each.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby enum_example.rb
#
# Requirements:
# - Ruby
#

class Enum
  include Enumerable
  def initialize(arr)
    @arr = arr
  end
  def each
    @arr.each { |e| yield(e) }
  end
end

p Enum.new([1,2,3]).map { |x| x + 1 }
