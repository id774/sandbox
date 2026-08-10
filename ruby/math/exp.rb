#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-
# Print the exponential and the natural and common logarithms.

x = 10

puts "指数関数 x=10"
p Math.exp(x)

# Logarithmic functions
puts "x の自然対数 (e を底とする対数)"
p Math.log (x) # loge (x)

puts "x の常用対数 (10 を底とする対数)"
p Math.log10 (x) # log10 (x)

