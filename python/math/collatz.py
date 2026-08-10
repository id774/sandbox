#!/usr/bin/env python3
# Print the start below 1000 with the longest Collatz sequence, found by max over a key function.

LIMIT = 1000


def chain_length(start):
    value = start
    length = 1
    while value != 1:
        value = value // 2 if value % 2 == 0 else 3 * value + 1
        length += 1
    return length


longest = max(range(1, LIMIT), key=chain_length)
print(longest, chain_length(longest))
