# firstclass_function.rb: Numeric derivative of a lambda
#
# Description:
# Pass a lambda to a function that returns its numeric derivative.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby firstclass_function.rb
#
# Requirements:
# - Ruby
#

def deriv(f, dx)
  ->(x){ f[x + dx] - f[x] }
end
 
sin = ->(x){ Math.sin(x) }
 
cos = deriv(sin, 0.00000001)
 
puts sin[Math::PI / 2]
puts cos[Math::PI / 2]
