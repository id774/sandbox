#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-
# exp.rb: Exponential and logarithms
#
# Description:
# Print the exponential and the natural and common logarithms.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby exp.rb
#
# Requirements:
# - Ruby
#

x = 10

puts "指数関数 x=10"
p Math.exp(x)

# Logarithmic functions
puts "x の自然対数 (e を底とする対数)"
p Math.log (x) # loge (x)

puts "x の常用対数 (10 を底とする対数)"
p Math.log10 (x) # log10 (x)

