# Print a Fibonacci series up to a limit and show the function docstring.

import sys

def fib(n):
    """Print a Fibonacci series up to n."""
    a, b = 0, 1
    while b < n:
        print(b),
        a, b = b, a + b

print(fib.__doc__)

fib(int(sys.argv[1]))
