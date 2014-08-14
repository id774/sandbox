import numpy as np

def cumsum(nparray):
    return nparray.cumsum()

a = np.array([
    [1, 2, 3],
    [4, 5, 6]
])

print(a.ndim)

b = np.array([
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
])

print(b.ndim)

c = np.array([
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [10.11]
])

print(c.ndim)

d = np.array([
    [[1, 2, 3],
     [4, 5, 6]],
    [[7, 8, 9],
     [10.11, 12]],
    [13, 14, 15],
    [16, 17, 18]
])

print(d.ndim)
