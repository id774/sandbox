# fibonacci.cr: The first 20 Fibonacci numbers
#
# Description:
# Print the first 20 Fibonacci numbers from an Iterator built out of a block.
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
#     crystal run fibonacci.cr
#
# Requirements:
# - Crystal 1.0 or later
# - No third-party package is required

current = 0
following = 1

fibonacci = Iterator.of do
  value = current
  current, following = following, current + following
  value
end

puts fibonacci.first(20).to_a.join(" ")
