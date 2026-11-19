# -*- coding: utf-8 -*-
# yield.rb: Yield values to a block
#
# Description:
# Yield values to a block from inside a method.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby yield.rb
#
# Requirements:
# - Ruby
#

def return_yield
  puts("Before the yield.")
  yield (20)
  yield (10)
  puts("After the yield.")
end

return_yield {|x|
  puts "#{x}"
}

