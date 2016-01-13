def prime_table(n):
    list = [True for _ in range(n + 1)]
    i = 2
    while i * i <= n:
        if list[i]:
            j = i + i
            while j <= n:
                list[j] = False
                j += i
        i += 1

    table = [i for i in range(n + 1) if list[i] and i >= 2]
    return table

def is_prime(n):
    i = 2
    while i * i <= n:
        if n % i == 0:
            return False
        i += 1
    return True

def prime_decomposition(n):
    i = 2
    table = []
    while i * i <= n:
        while n % i == 0:
            n /= i
            table.append(i)
        i += 1
    if n > 1:
        table.append(n)
    return table

print((prime_table(100)))
print((is_prime(100)))
print((prime_decomposition(100)))
