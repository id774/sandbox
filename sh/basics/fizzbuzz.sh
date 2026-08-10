#!/bin/sh
# Print FizzBuzz for 1 through 100, choosing the label with a case over the remainders.

n=1
while [ "$n" -le 100 ]; do
    case "$((n % 3)),$((n % 5))" in
        0,0) echo "FizzBuzz" ;;
        0,*) echo "Fizz" ;;
        *,0) echo "Buzz" ;;
        *) echo "$n" ;;
    esac
    n=$((n + 1))
done
