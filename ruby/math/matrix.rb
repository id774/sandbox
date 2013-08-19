#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-

require 'matrix'

# 線型方程式系

# 2x + 4y - 2z = 4
# 2x +  y +  z = 7
#  x +  y +  z = 6

# 三元一次方程式の係数を行列で記述する
# A・X = B 変形すると X = (1/A)・B = A-1・B (A-1 は逆行列)

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


# 四元一次方程式の係数を行列で記述する

# 2x +  y + 3z + 4w =  2
# 3x + 2y + 5z + 2w = 12
# 3x + 4y +  z -  w =  4
# -x - 3y +  z + 3w = -1

# A・X = B 変形すると X = A-1・B (A-1 は逆行列)

a = Matrix[[2, 1, 3, 4],
           [3, 2, 5, 2],
           [3, 4, 1, -1],
           [-1, -3, 1, 3]]

b = Vector[2, 12, 4, -1]

puts a.inv*b
puts (1/a)*b

# 解答 X = Vector[x, y, z, w]  = Vector[1/1, -1/1, 3/1, -2/1]
# 解は，x = 1 y = -1 z = 3 w = -2 である

