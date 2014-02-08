require 'narray'

na = NArray.int(3,3).indgen!(1,1)

p na
p na.class

p na[true, 1]

p na[true, 1].sum

p na[0, true]
p na[0, true].sum

p na[true, [0, 1]]
p na[true, [0, 1]].sum(0)
p na[true, [0, 1]].sum(1)
p na[true, [0, 1]].sum
