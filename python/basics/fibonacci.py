#!/usr/bin/env python3
# Print the first 20 Fibonacci numbers from a generator.

from itertools import islice


def fibonacci():
    current, following = 0, 1
    while True:
        yield current
        current, following = following, current + following


print(" ".join(str(value) for value in islice(fibonacci(), 20)))
