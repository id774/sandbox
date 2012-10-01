#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

comma = "、"
period = "。"
sentence = ""

rand(10).times do
  if rand(2) == 0
    sentence << comma
  else
    sentence << period
  end
end

puts sentence
