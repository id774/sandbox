#!/bin/bash
# Print FizzBuzz for 1 through 100, choosing the label with a case over the remainders.

for ((n = 1; n <= 100; n++)); do
    case "$((n % 3)),$((n % 5))" in
        0,0) echo "FizzBuzz" ;;
        0,*) echo "Fizz" ;;
        *,0) echo "Buzz" ;;
        *) echo "$n" ;;
    esac
done
