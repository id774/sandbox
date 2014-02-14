# -*- coding:utf-8 -*_

import numpy as np

X = np.array([0.02, 0.12, 0.19, 0.27, 0.42, 0.51, 0.64, 0.84, 0.88, 0.99])
Y = np.array([0.05, 0.87, 0.94, 0.92, 0.54, -0.11, -0.78, -0.79, -0.89, -0.04])

def element_product(x, y):
    """ 要素積 """
    return (x * y)

def matrix_product(x, y):
    """ 行列積 """
    return (np.dot(x, y))

def direct_product(x, y):
    """ 直積 """
    return (np.outer(x, y))

print(element_product.__doc__)
print(element_product(X, Y))

print(matrix_product.__doc__)
print(matrix_product(X, Y))

print(direct_product.__doc__)
print(direct_product(X, Y))
