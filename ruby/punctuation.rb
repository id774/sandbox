#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

def yuyu_punctuation(length)
  comma = "、"
  period = "。"
  sentence = ""
  (rand(length)+1).times do
    rand(2) == 0 ? sentence << comma : sentence << period
  end
  sentence
end

if __FILE__ == $0
  puts yuyu_punctuation(10)
end
