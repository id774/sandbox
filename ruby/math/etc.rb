#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-

puts "平方根"
n = 2
p Math::sqrt(n)

puts "自然対数の底 e の値"
p Math::E

puts "三角関数"
deg = 30
rad = (deg * Math::PI/180.0) # 度 -> ラジアン変換
puts " sin(Θ) 正弦関数"
p Math.sin(rad)
puts " cos(Θ) 余弦関数"
p Math.cos(rad)
puts " cos(Θ) 正接関数"
p Math.tan(rad)

