#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

class Numeric
  def to_proc
    if self == 1 then lambda {|x| x}
    else raise
    end
  end
end

p [1,2,3].map(&1)
