#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'benchmark'

# Implement original lazy class

class Lazy
  def initialize
    @proc = Proc.new
    @obj = nil
  end

  def method_missing(method, *args, &block)
    if @proc
      @obj = @proc.call
      @proc = nil end
    @obj.__send__(method, *args, &block)
  end
end

def lazy(&proc)
  Lazy.new(&proc)
end


# Takeuchi function

def tak(x, y, z)
  if x <= y.to_i
    y
  else
    tak(tak(x-1, y, z), tak(y-1,z,x), tak(z-1,x,y)) end end

def ltak(x, y, z)
  lazy{
    if x <= y.to_i
      y
    else
      ltak(ltak(x-1, y, z), ltak(y-1,z,x), ltak(z-1,x,y)) end } end

def btak(x, y, z)
  if x <= y.to_i
    y
  else
    btak(btak(x-1, y, z), btak(y-1,z,x), lazy{ btak(z-1,x,y) }) end end

p Benchmark.realtime{ tak(12,6,0).to_i }
p Benchmark.realtime{ ltak(12,6,0).to_i }
p Benchmark.realtime{ btak(12,6,0).to_i }
