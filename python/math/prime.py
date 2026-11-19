# prime.py: Endless prime generator from chained filters
#
# Description:
# Generate primes endlessly with a chain of filters over a counter.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 prime.py
#
# Requirements:
# - Python 3
#

from itertools import count
def prime_generator():
    g = count(2)
    while True:
        prime = next(g)
        yield prime
        g = filter(lambda x, prime=prime: x % prime, g)

for pr in prime_generator():
    print(pr)
