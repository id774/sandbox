#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# Wrap a minimum length rule in a class that answers allow?.

class Criteria
  def initialize(length)
    @length = length
  end

  def allow?(s)
    s.length >= @length
  end
end
