# -*- coding: utf-8 -*-
# closure.rb: A block closes over its surrounding variables
#
# Description:
# Show that a block closes over the variables where it was written.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby closure.rb
#
# Requirements:
# - Ruby
#

def my_method
  x = "Goodbye"
  yield("cruel")
end

x = "Hello"
puts my_method {|y| "#{x}, #{y} world" }

