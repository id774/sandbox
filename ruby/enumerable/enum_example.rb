#!/opt/ruby/1.9.3/bin/ruby
# -*- coding: utf-8 -*-

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
