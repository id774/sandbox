#!/opt/ruby/2.2/bin/ruby
# enumerable.rb: slice_before, slice_after, slice_when, and min and max variants
#
# Description:
# Exercise slice_before, slice_after, slice_when, and the min and max
# variants.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby enumerable.rb
#
# Requirements:
# - Ruby 2.2 or later, which provides slice_when and min and max with a
#   count
#

print *[1, 1, 2, 3, 3, 4, 5].slice_before(&:even?), "\n"
print *[1, 1, 2, 3, 3, 4, 5].slice_after(&:even?), "\n"

print [1, 1, 2, 3, 3, 4, 5].slice_when { |a, b| a.odd? && b.even? }.to_a

print [*'1'..'11'].min(3), "\n"
print [*'1'..'11'].min_by(3) { |e|e.to_i }, "\n"
print [*'1'..'11'].max(3), "\n"
print [*'1'..'11'].max_by(3) { |e|e.to_i }, "\n"

