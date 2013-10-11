# -*- coding: utf-8 -*-
require 'awesome_print'

puts "倍精度"
ap 1.0 + 1e-15
ap 1.0 + 1e-16
ap 1e308
ap 1e309
ap 1e-307
ap 1e-308
ap 1e-323
ap 1e-324

puts "二進数と十進数の誤差"
t = 0.0
i = 0
while (t < 1.0)
  puts "#{i},#{t}"
  t += 0.1
  i += 1
end

