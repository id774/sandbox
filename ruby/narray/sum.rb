require 'narray'

na = NArray.int(3,3).indgen!(1,1)

p na
p na.class

p na[true, 1]

p na[true, 1].sum
