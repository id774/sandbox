def hello(a:, b:1, c:, d:2)
  p a
  p b
  p c
  p d
end
 
def world(a, b=1, *c, d:, e:2, f:, **g, &h)
  p a
  p b
  p c
  p d
  p e
  p f
  p g
  p h
end

hello(a: 3, c: 4)
world(3, b=0, 4, d: 5, f: 6, g: 7, h: 8)
