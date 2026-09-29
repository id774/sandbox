#!/usr/bin/env ruby
# quicksort.rb: Quicksort of a fixed integer sequence
#
# Description:
# Sort a fixed array with a quicksort over the head and tail of the array.
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
#     ruby quicksort.rb
#
# Requirements:
# - Ruby 3.0 or later
# - No third-party package is required

def quicksort(items)
  return items if items.size <= 1

  pivot, *rest = items
  quicksort(rest.select { |x| x <= pivot }) + [pivot] + quicksort(rest.select { |x| x > pivot })
end

puts quicksort([5, 3, 8, 4, 2, 7, 1, 10, 9, 6]).join(' ')
