# -*- coding: utf-8 -*-
# scope_of_block.rb: Variables that survive outside a block
#
# Description:
# Show which variables survive outside a block.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby scope_of_block.rb
#
# Requirements:
# - Ruby
#

def my_method
  yield
end

top_level_var = 1

my_method {
  top_level_var += 1
  local_to_block = 3
}

p top_level_var
p local_to_block

