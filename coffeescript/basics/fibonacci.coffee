# fibonacci.coffee: The first 20 Fibonacci numbers
#
# Description:
# Print the first 20 Fibonacci numbers, collected into an array.
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
#     coffee fibonacci.coffee
#
# Requirements:
# - CoffeeScript 2.0 or later (coffee)
# - Node.js 20 or later
# - No third-party package is required

fibonacci = (count) ->
  values = []
  [current, following] = [0, 1]
  for _ in [1..count]
    values.push current
    [current, following] = [following, current + following]
  values

console.log fibonacci(20).join ' '
