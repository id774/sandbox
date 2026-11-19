# keyword_args_with_no_default_val.rb: Required keyword arguments
#
# Description:
# Declare required keyword arguments alongside every other parameter kind.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby keyword_args_with_no_default_val.rb
#
# Requirements:
# - Ruby 2.1 or later, which supports required keyword arguments
#

def hello(a:, b:1, c:, d:2)
  p a
  p b
  p c
  p d
end
 
def world(a, b=1, *c, d:, e:2, f:, **g, &h)
  p a
  p b
  p c
  p d
  p e
  p f
  p g
  p h
end

hello(a: 3, c: 4)
world(3, b=0, 4, d: 5, f: 6, g: 7, h: 8)
