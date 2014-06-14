import numpy as np

def is_prime(q):
    q = abs(q)
    if q == 2: return True
    if q < 2 or q&1 == 0: return False
    return pow(2, q-1, q) == 1

for x in range(30100):
    print(x,is_prime(x))

