#!/usr/bin/env ruby
# fibonacci.rb: The first 20 Fibonacci numbers
#
# Description:
# Print the first 20 Fibonacci numbers from a lazy Enumerator.
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
#     ruby fibonacci.rb
#
# Requirements:
# - Ruby 3.0 or later
# - No third-party package is required

fibonacci = Enumerator.new do |yielder|
  current = 0
  following = 1
  loop do
    yielder << current
    current, following = following, current + following
  end
end

puts fibonacci.take(20).join(' ')
