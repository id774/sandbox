#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

def yuyu_punctuation
  comma = "、"
  period = "。"
  sentence = ""
  rand(10).times do
    rand(2) == 0 ? sentence << comma : sentence << period
  end
  sentence
end

if __FILE__ == $0
  puts yuyu_punctuation
end
