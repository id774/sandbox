#!/opt/ruby/2.2/bin/ruby
# curry.rb: Curry a three-argument method
#
# Description:
# Curry a three argument method and apply the arguments one at a time.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby curry.rb
#
# Requirements:
# - Ruby 2.2 or later, which provides Method#curry
#

def trapezoid(upper_base, lower_base, hight)
  (upper_base + lower_base) * hight / 2
end

trapezoid_10_20 = method(:trapezoid).curry(3).(10).(20)
p trapezoid_10_20.(2)
p trapezoid_10_20.(4)
