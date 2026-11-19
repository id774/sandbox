# calc_fibonacci.py: Endless Fibonacci generator
#
# Description:
# Yield Fibonacci numbers endlessly from a generator.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 calc_fibonacci.py
#
# Requirements:
# - Python 3
#

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
