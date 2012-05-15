def deriv(f, dx)
  ->(x){ f[x + dx] - f[x] }
end
 
sin = ->(x){ Math.sin(x) }
 
cos = deriv(sin, 0.00000001)
 
puts sin[Math::PI / 2]
puts cos[Math::PI / 2]
