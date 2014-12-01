def x(n):
    print(n)
    return n

r = all([x(n) < 3 for n in range(5)])
print(r)

r = all(x(n) < 3 for n in range(5))
print(r)
