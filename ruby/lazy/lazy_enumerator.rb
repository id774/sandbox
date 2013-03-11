#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

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
