#!/usr/bin/env python
# -*- coding: utf-8 -*-

import math
import numpy as np
import matplotlib.pyplot as plt

def split_array(data):
    v1 = []
    v2 = []
    for x, y in data:
        v1.append(x)
        v2.append(y)
    return v1, v2

def correlation(data):
    n = len(data)
    xm = 0.0
    ym = 0.0
    for x, y in data:
        xm += x
        ym += y
    xm /= n
    ym /= n
    sx2 = 0.0
    sy2 = 0.0
    sxy = 0.0
    for x, y in data:
        sx2 += (x - xm) ** 2
        sy2 += (y - ym) ** 2
        sxy += (x - xm) * (y - ym)
    return sxy / math.sqrt(sx2 * sy2)

def correlation2(data):
    xm = 0.0
    ym = 0.0
    sx2 = 0.0
    sy2 = 0.0
    sxy = 0.0
    i = 0
    for x, y in data:
        i += 1
        x -= xm
        xm += x / i
        sx2 += (i - 1) * x * x / i
        y -= ym
        ym += y / i
        sy2 += (i - 1) * y * y / i
        sxy += (i - 1) * x * y / i
    return sxy / math.sqrt(sx2 * sy2)

def rank_correlation(data):
    n = len(data)
    d = 0
    for x, y in data:
        d += (x - y) ** 2
    return 1.0 - 6.0 * d / (n ** 3 - n)

def regression(data):
    n = len(data)
    xm = 0.0
    ym = 0.0
    for x, y in data:
        xm += x
        ym += y
    xm /= n
    ym /= n
    sx2 = 0.0
    sxy = 0.0
    for x, y in data:
        sx2 += (x - xm) ** 2
        sxy += (x - xm) * (y - ym)
    a = sxy / sx2
    return a, ym - a * xm

def regression2(data):
    xm = 0.0
    ym = 0.0
    sx2 = 0.0
    sxy = 0.0
    i = 0
    for x, y in data:
        i += 1
        x -= xm
        xm += x / i
        sx2 += (i - 1) * x * x / i
        y -= ym
        ym += y / i
        sxy += (i - 1) * x * y / i
    a = sxy / sx2
    return a, ym - a * xm

# 強い正の相関
rank1 = [
    (1, 2), (2, 1), (3, 3), (4, 4),
    (5, 5), (6, 7), (7, 6), (8, 8),
    (9, 9), (10, 11), (11, 10), (12, 13),
    (13, 18), (14, 12), (15, 23), (16, 14),
    (17, 19), (18, 16), (19, 20), (20, 15),
    (21, 17), (22, 21), (23, 25), (24, 24),
    (25, 22), (26, 27), (27, 26), (28, 29),
    (29, 28), (30, 30)
]

# 弱い正の相関
rank2 = [
    (1, 2), (2, 4), (3, 18), (4, 23),
    (5, 7), (6, 5), (7, 19), (8, 11),
    (9, 3), (10, 13), (11, 20), (12, 25),
    (13, 6), (14, 29), (15, 1), (16, 10),
    (17, 12), (18, 24), (19, 30), (20, 16),
    (21, 21), (22, 26), (23, 14), (24, 15),
    (25, 9), (26, 27), (27, 8), (28, 28),
    (29, 17), (30, 22)
]

# 強い負の相関
rank3 = [
    (1, 30), (2, 29), (3, 26), (4, 25),
    (5, 27), (6, 23), (7, 22), (8, 24),
    (9, 28), (10, 19), (11, 21), (12, 20),
    (13, 16), (14, 11), (15, 17), (16, 18),
    (17, 14), (18, 13), (19, 12), (20, 5),
    (21, 10), (22, 15), (23, 7), (24, 9),
    (25, 6), (26, 4), (27, 8), (28, 3),
    (29, 2), (30, 1)
]

# 弱い負の相関
rank4 = [
    (1, 27), (2, 25), (3, 19), (4, 20),
    (5, 1), (6, 21), (7, 10), (8, 18),
    (9, 22), (10, 24), (11, 30), (12, 16),
    (13, 17), (14, 4), (15, 26), (16, 14),
    (17, 5), (18, 28), (19, 12), (20, 13),
    (21, 23), (22, 6), (23, 29), (24, 11),
    (25, 9), (26, 3), (27, 15), (28, 8),
    (29, 7), (30, 2)
]

data1 = [
    (4.6, 5.5), (0.0, 1.7), (6.4, 7.2), (6.5, 8.3),
    (4.4, 5.7), (1.1, 1.1), (2.8, 4.1), (5.1, 6.7),
    (3.4, 5.0), (5.8, 6.6), (5.7, 6.3), (5.5, 5.6),
    (7.9, 8.7), (3.0, 3.6), (6.8, 8.2), (6.2, 6.2),
    (4.0, 5.0), (8.6, 9.5), (7.5, 8.9), (1.3, 2.6),
    (6.3, 7.4), (3.1, 5.0), (6.1, 8.2), (5.3, 6.6),
    (3.9, 5.1), (5.8, 7.0), (2.6, 3.5), (4.8, 6.3),
    (2.2, 2.9), (5.3, 6.9)
]

data2 = [
    (4.6, 5.2), (0.0, 7.6), (6.4, 5.6), (6.5, 10.1),
    (4.4, 8.0), (1.1, 0.0), (2.8, 6.5), (5.1, 10.2),
    (3.4, 10.4), (5.8, 5.3), (5.7, 3.3), (5.5, 0.0),
    (7.9, 7.0), (3.0, 0.5), (6.8, 10.4), (6.2, 0.0),
    (4.0, 4.7), (8.6, 8.7), (7.5, 10.7), (1.3, 4.8),
    (6.3, 8.1), (3.1, 10.7), (6.1, 17.9), (5.3, 9.0),
    (3.9, 7.6), (5.8, 9.5), (2.6, 2.8), (4.8, 10.2),
    (2.2, 0.0), (5.3, 10.8)
]

data3 = [
    (6.1, 3.7), (3.9, 7.5), (8.6, 1.7), (5.9, 3.9),
    (3.5, 5.5), (7.0, 2.4), (0.9, 9.8), (0.0, 10.2),
    (5.2, 4.2), (3.5, 6.5), (6.9, 3.2), (4.3, 5.9),
    (5.0, 5.9), (7.4, 3.3), (3.1, 6.6), (4.0, 6.2),
    (6.9, 2.9), (4.8, 5.0), (10.6, 0.0), (4.7, 4.3),
    (2.9, 7.6), (7.2, 2.2), (3.6, 6.0), (5.5, 4.3),
    (5.5, 4.5), (6.9, 3.2), (5.8, 3.6), (4.8, 4.6),
    (7.3, 2.5), (4.7, 5.4)
]

data4 = [
    (3.5, 10.2), (8.0, 0.0), (10.2, 3.0), (2.1, 10.8),
    (2.8, 7.2), (3.7, 2.1), (5.1, 2.2), (7.5, 0.2),
    (7.6, 4.6), (5.3, 0.3), (4.7, 6.0), (8.3, 5.4),
    (4.8, 4.7), (6.6, 2.2), (2.4, 10.0), (4.4, 5.6),
    (3.6, 9.3), (7.0, 3.0), (4.9, 3.1), (2.7, 4.4),
    (9.2, 7.3), (3.7, 7.8), (0.8, 1.0), (4.8, 10.0),
    (6.5, 1.1), (6.3, 0.9), (2.7, 4.9), (5.0, 3.9),
    (3.4, 10.5), (6.6, 6.7),
]

data = [
    (0, 15.6),  (1, 15.0),  (2, 15.8),  (3, 16.1), (4, 16.9),
    (5, 15.4),  (6, 15.0),  (7, 16.0),  (8, 15.7), (9, 14.9),
    (10, 15.7), (11, 15.2), (12, 16.3), (13, 15.4), (14, 16.4),
    (15, 17.0), (16, 16.4), (17, 16.0), (18, 15.5), (19, 16.9),
    (20, 16.3), (21, 15.8), (22, 16.7), (23, 16.7), (24, 17.0),
    (25, 16.9), (26, 16.5), (27, 16.7), (28, 16.0), (29, 17.3),
    (30, 16.2), (31, 16.4)
]

print ( correlation(data1) )
print ( correlation2(data1) )
print ( correlation(rank1) )
print ( correlation(rank2) )
print ( correlation(rank3) )
print ( correlation(rank4) )
print ( rank_correlation(rank1) )
print ( rank_correlation(rank2) )
print ( rank_correlation(rank3) )
print ( rank_correlation(rank4) )
print ( regression(data1) )
print ( regression(data2) )
print ( regression(data3) )
print ( regression(data4) )
print ( regression2(data1) )
print ( regression2(data2) )
print ( regression2(data3) )
print ( regression2(data4) )
print ( correlation(data) )
print ( regression(data) )

v1, v2 = split_array(data)
print (v1)
print (v2)
print ( np.corrcoef(v1, v2) )


def plot2data(v1, v2, filename):
    plt.xlim(0, 35)
    plt.ylim(14.5, 17.5)

    def phi(x):
        return [1, x, x**2, x**3]

    def f(w, x):
        return np.dot(w, phi(x))

    PHI = np.array([phi(x) for x in v2])
    w = np.linalg.solve(np.dot(PHI.T, PHI), np.dot(PHI.T, v1))

    ylist = np.arange(10, 20, 0.1)
    xlist = [f(w, x) for x in ylist]
    plt.plot(xlist, ylist, color="red")

    plt.xlabel('X')
    plt.ylabel('Y')
    plt.plot(v1, v2, 'o', color="blue")
    plt.savefig(filename)

v1, v2 = split_array(data)
plot2data(v1, v2, "image.png")

