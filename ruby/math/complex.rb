#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-

require 'complex'
x = Complex(0,1)
y = x ** 2             #=>  Complex(-1,0)
z = Math::sqrt(x)      #=>  Complex(0.707106781186547, 0.707106781186547)

p x
p y
p z

p Complex(1)
p Complex(2,3)
p Complex.polar(2,3)
p Complex(0,3)
p Complex('0.3-0.5i')

p Complex('2/3+3/4i')
p Complex('1@2')
p 3.to_c
p 0.3.to_c
p '0.3-0.5i'.to_c
p '2/3+3/4i'.to_c
p '1@2'.to_c

p Complex(1, 1) / 2
p Complex(1, 1) / 2.0

