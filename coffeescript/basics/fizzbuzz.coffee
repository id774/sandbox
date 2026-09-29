# fizzbuzz.coffee: FizzBuzz for 1 through 100
#
# Description:
# Print FizzBuzz for 1 through 100, with the label picked by a helper function.
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
#     coffee fizzbuzz.coffee
#
# Requirements:
# - CoffeeScript 2.0 or later (coffee)
# - Node.js 20 or later
# - No third-party package is required

label = (n) ->
  if n % 15 is 0 then 'FizzBuzz'
  else if n % 3 is 0 then 'Fizz'
  else if n % 5 is 0 then 'Buzz'
  else String n

console.log label n for n in [1..100]
