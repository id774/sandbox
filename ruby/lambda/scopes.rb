# -*- coding: utf-8 -*-
# scopes.rb: local_variables in different scopes
#
# Description:
# Compare local_variables at top level, in a class body, and in a method.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby scopes.rb
#
# Requirements:
# - Ruby
#

v1 = 1

class MyClass

  v2 = 2
  p local_variables

  def my_method
    v3 = 3
    p local_variables
  end

  p local_variables

end

obj = MyClass.new
obj.my_method
p local_variables

