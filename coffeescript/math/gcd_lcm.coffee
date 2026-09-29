# gcd_lcm.coffee: GCD and LCM of fixed pairs by Euclid's algorithm
#
# Description:
# Print the divisor and multiple of fixed pairs, with Euclid's algorithm run on a destructured swap.
#
# Part of the math cross-language exercise set: it reads no arguments or
# standard input, keeps its data fixed in the source, uses integer
# arithmetic only, and its output is the same as that of the same exercise
# in every other language. The exercises are specified in README.md at the
# repository root.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     coffee gcd_lcm.coffee
#
# Requirements:
# - CoffeeScript 2.0 or later (coffee)
# - Node.js 20 or later
# - No third-party package is required

pairs = [[1071, 462], [270, 192], [17, 5], [120, 36]]

gcd = (first, second) ->
  while second isnt 0
    [first, second] = [second, first % second]
  first

for [first, second] in pairs
  divisor = gcd(first, second)
  console.log "#{first} #{second} #{divisor} #{first / divisor * second}"
