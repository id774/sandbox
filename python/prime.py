from itertools import count
def prime_generator():
    g = count(2)
    while True:
        prime = next(g)
        yield prime
        g = filter(lambda x, prime=prime: x % prime, g)

for pr in prime_generator():
    print(pr)
