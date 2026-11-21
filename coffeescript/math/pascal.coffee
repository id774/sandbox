# pascal.coffee: The first 10 rows of Pascal's triangle
#
# Description:
# Print 10 rows of Pascal's triangle, each row summed from the previous one shifted both ways.
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
#     coffee pascal.coffee
#
# Requirements:
# - CoffeeScript compiler (coffee)
# - Node.js runtime
# - No third-party package is required
#
# Verified Environment:
# Tested with CoffeeScript 2.7.1 and Node.js 22.23.5.

rows = 10

row = [1]
for i in [0...rows]
  console.log row.join ' '
  shifted = [0].concat row
  padded = row.concat [0]
  row = (value + padded[index] for value, index in shifted)
