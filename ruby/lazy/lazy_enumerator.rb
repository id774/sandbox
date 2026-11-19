#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# lazy_enumerator.rb: Lazy enumerator built on Enumerator
#
# Description:
# Implement a lazy enumerator on top of Enumerator.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby lazy_enumerator.rb
#
# Requirements:
# - Ruby
#

module Enumerable
  class Lazy < Enumerator

    def initialize(obj)
      super() do |yielder|
        obj.each do |val|
          if block_given?
            yield(yielder, val)
          else
            yielder << val
          end
        end
      end
    end

    def map
      Lazy.new(self) do |yielder, val|
        yielder << yield(val)
      end
    end

  end
end

a = Enumerable::Lazy.new([1,2,3])
a = a.map { |x| x * 10 }.map { |x| x - 1 }
puts a.next #=> 9
puts a.next #=> 19
