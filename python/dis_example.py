from dis import dis

def list_comprehensions(i=10):
    power_list = [n ** 2 for n in range(i)]
    return power_list

def generator(i=10):
    power_gen = (n ** 2 for n in range(i))
    return power_gen

print(list_comprehensions())
dis(list_comprehensions)

for n in generator():
    print(n)
dis(generator)
