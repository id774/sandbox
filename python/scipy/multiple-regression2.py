
import numpy as np
from scipy import linalg

x = [15, 5]
y = [-10, -20]
z = [30, 45]

print("x", x)
print("y", y)
print("z", z)

def multi_regression(x, y, z):
    N = len(x)
    G = np.array([x, y, np.ones(N)]).T
    result = linalg.solve(G.T.dot(G), G.T.dot(z))
    return result

result = multi_regression(x, y, z)
print("result", result)
