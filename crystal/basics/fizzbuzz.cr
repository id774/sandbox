# fizzbuzz.cr: FizzBuzz for 1 through 100
#
# Description:
# Print FizzBuzz for 1 through 100, choosing the label by matching a tuple of remainders.
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
#     crystal run fizzbuzz.cr
#
# Requirements:
# - Crystal 1.0 or later
# - No third-party package is required

def fizzbuzz_label(n : Int32) : String
  case {n % 3, n % 5}
  when {0, 0} then "FizzBuzz"
  when {0, _} then "Fizz"
  when {_, 0} then "Buzz"
  else             n.to_s
  end
end

(1..100).each { |n| puts fizzbuzz_label(n) }
