#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-

# 線型方程式系

# A・X = B 変形すると X = (1/A)・B = A-1・B (A-1 は逆行列)

require 'matrix'

a = Matrix[[2, 4, -2],
           [2, 1,  1],
           [1, 1,  1]]

b = Vector[4,
           7,
           6]

puts a.inv*b
puts (1/a)*b


# 解答 X = Vector[x, y, z] = Vector[1/1, 2/1, 3/1] であるから
# 解は x = 1 y = 2 z = 3 である
