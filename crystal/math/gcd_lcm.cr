# gcd_lcm.cr: GCD and LCM of fixed pairs by Euclid's algorithm
#
# Description:
# Print the divisor and multiple of fixed pairs, with Euclid's algorithm written out rather than taken from Int.
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
#     crystal run gcd_lcm.cr
#
# Requirements:
# - Crystal 1.0 or later
# - No third-party package is required

PAIRS = [{1071, 462}, {270, 192}, {17, 5}, {120, 36}]

def euclid(first : Int32, second : Int32) : Int32
  while second != 0
    first, second = second, first % second
  end
  first
end

PAIRS.each do |(first, second)|
  divisor = euclid(first, second)
  puts "#{first} #{second} #{divisor} #{first // divisor * second}"
end
