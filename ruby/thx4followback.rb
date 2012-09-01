#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

f = "フォロバ"
o = "乙"
a = "あり"
d = "ですー"
s = ""
s << f

rand(100).times do
  if rand(2) == 0
    s << o
  else
    s << a
  end
end

s << d
p s
