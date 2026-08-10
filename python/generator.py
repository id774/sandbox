# Pull successive values from a generator with next().

def my_generator():
    yield 10
    yield 20
    yield 30

def main():
    gen = my_generator()
    print(next(gen))
    print(next(gen))
    print(next(gen))

main()
