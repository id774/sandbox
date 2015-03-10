import sys
from matplotlib import pyplot as plt

MAXIT = int(sys.argv[1])

def collatz(x):
    lists = []
    while x != 1:
        x = x / 2 if x % 2 == 0 else x * 3 + 1
        lists.append(x)
    return lists

cs = [len(collatz(i)) for i in range(2, MAXIT + 1)]
plt.figure()
plt.plot(range(2, MAXIT + 1), cs, "ro")
plt.savefig("image.png")
plt.close()
