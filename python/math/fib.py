# fib.py: Fibonacci series up to a limit
#
# Description:
# Print a Fibonacci series up to the limit given as the first argument and
# show the function docstring.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 fib.py <limit>
#
# Requirements:
# - Python 3
#

import sys

def fib(n):
    """Print a Fibonacci series up to n."""
    a, b = 0, 1
    while b < n:
        print(b),
        a, b = b, a + b

print(fib.__doc__)

fib(int(sys.argv[1]))
