# 2.4_test1.rb: Multiple assignment as a condition
#
# Description:
# Show that multiple assignment in a condition is true for an array and false
# for nil.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby 2.4_test1.rb
#
# Requirements:
# - Ruby 2.4 or later
#

def some_method_returning_array_or_nil(flag)
  flag ? [1, 2] : nil
end

def test_multiple_assignment_in_conditional_expression
  # Returning an array is treated as true
  if (a, b = some_method_returning_array_or_nil(true))
    assert true
  else
    flunk 'should be true'
  end

  # Returning nil is treated as false
  if (a, b = some_method_returning_array_or_nil(false))
    flunk 'should be false'
  else
    assert true
  end
end
