# collatz.cr: Longest Collatz sequence for a start below 1000
#
# Description:
# Print the start below 1000 with the longest Collatz sequence, picked by max_by over a range.
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
#     crystal run collatz.cr
#
# Requirements:
# - Crystal 1.0 or later
# - No third-party package is required

LIMIT = 1000

def chain_length(start : Int32) : Int32
  value = start
  length = 1
  while value != 1
    value = value.even? ? value // 2 : value * 3 + 1
    length += 1
  end
  length
end

longest = (1...LIMIT).max_by { |start| chain_length(start) }
puts "#{longest} #{chain_length(longest)}"
