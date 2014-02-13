#!/usr/bin/python
# -*- coding: utf-8 -*-
from pprint import pprint, pformat
import random


def randomize(items):
    randomized = []
    while 0 < len(items):
        idx = random.randint(0, len(items)-1)
        popped = items[idx]
        del items[idx]
        randomized.append(popped)
    return randomized


if __name__ == '__main__':
    x = [1, 2, 3, 4, 5]
    y = [10, 20, 30, 40, 50, 60, 70]
    z = [111, 222, 333, 444, 555, 666, 777, 888, 999]

    print('x = %s' % pformat(x))
    print('randomized x = %s' % pformat(randomize(x)))

    print('y = %s' % pformat(y))
    print('randomized y = %s' % pformat(randomize(y)))

    print('z = %s' % pformat(z))
    print('randomized z = %s' % pformat(randomize(z)))