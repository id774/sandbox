import numpy as np
import scipy as sp

def cumsum(nparray):
    return nparray.cumsum()

a = np.array([
    [1, 2, 3],
    [4, 5, 6]
])

print(a)
print(np.cumsum(a))

b = np.array([
    [2, 4, 6],
    [8, 10, 12]
])

print(b)
print(np.cumsum(b))

print(np.cumsum(a, axis=0))
print(np.cumsum(a, axis=1))
