from itertools import cycle
import numpy as np
c = cycle('ABCDEFGH')
lis = np.arange(0, 100)

for i, c in zip(lis, c):
    print(i, c)
