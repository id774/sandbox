#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-

require 'complex'
x = Complex(0,1)
y = x ** 2             #=>  Complex(-1,0)
z = Math::sqrt(x)      #=>  Complex(0.707106781186547, 0.707106781186547)

p x
p y
p z
