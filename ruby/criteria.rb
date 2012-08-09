#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

class Criteria
  def initialize(length)
    @length = length
  end

  def allow?(s)
    s.length >= @length
  end
end
