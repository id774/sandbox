require 'narray'

na = NArray.int(3,2,2).indgen!(1,1)

p na

p na[0,0,0]
p na[0,1,0]
p na[0,0,1]

p na[true, true, 0]
p na[true, true, 0].sum
p na[true, 0, true]
p na[true, 0, true].sum
