#!/bin/sh
# fizzbuzz.sh: FizzBuzz for 1 through 100
#
# Description:
# Print FizzBuzz for 1 through 100, choosing the label with a case over the remainders.
#
# Part of the basics cross-language exercise set: the input is fixed in the
# source, and the output is the same as that of the same exercise in every
# other language. The exercises are specified in README.md at the
# repository root.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     sh fizzbuzz.sh
#
# Requirements:
# - A POSIX.1-2008 sh, such as dash 0.5 or later
# - No third-party package is required

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
