def calc_fibonacci():
    yield 1
    yield 1
    n = 1
    m = 1

    while True:
        yield n + m
        o = n + m
        n = m
        m = o

import time
for f in calc_fibonacci():
    print(f)
    time.sleep(0.1)

