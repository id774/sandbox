#!/bin/zsh
# Print FizzBuzz for 1 through 100, choosing the label with a case over the remainders.

for n in {1..100}; do
    case "$((n % 3)),$((n % 5))" in
        0,0) print "FizzBuzz" ;;
        0,*) print "Fizz" ;;
        *,0) print "Buzz" ;;
        *) print $n ;;
    esac
done
