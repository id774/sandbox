import numpy as np
import cramer

def run_cramer():
    L = [2, 3, 0, 5,
         1, 1, 1, 3,
         2,-1, 3, 7]
    A = np.array(L)
    A.shape = (3,4)
    result = cramer.solve(A)
    if result:
        x,y,z = result
        print('solution')
        print('x =', x)
        print('y =', y)
        print('z =', z, '\n')
        cramer.check(A,x,y,z)

run_cramer()
