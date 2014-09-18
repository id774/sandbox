from dis import dis
import numpy as np

def list_comprehensions(ary=np.arange(1, 10)):
    return [x * 2 for x in ary if x % 2 == 1]

def map_and_filter(ary=np.arange(1, 10)):
    return map(lambda x: x * 2, filter(lambda x: x % 2 == 1, ary))

print(list_comprehensions())
dis(list_comprehensions)
print(map_and_filter())
dis(map_and_filter)
