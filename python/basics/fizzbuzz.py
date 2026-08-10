#!/usr/bin/env python3
# Print FizzBuzz for 1 through 100, choosing the label with a match on the remainders.


def label(n: int) -> str:
    match (n % 3, n % 5):
        case (0, 0):
            return "FizzBuzz"
        case (0, _):
            return "Fizz"
        case (_, 0):
            return "Buzz"
        case _:
            return str(n)


for number in range(1, 101):
    print(label(number))
