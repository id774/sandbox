from numpy import *

a = array([1, 2, 3])
print(a)

f = array([1, 2, 3], dtype=float)
print(f)

a = arange(0, 10, 0.1)
print(a)

a = linspace(0, 2, 20)
print(a)
print(len(a))

data = loadtxt("data.txt")
print(data)
print(data[1, :])
print(data[:, 1])
