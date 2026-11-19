# Object_send.rb: Call a method chosen at run time with Object#send
#
# Description:
# Call upcase or downcase on a word through Object#send, choosing the method
# name from a condition.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby Object_send.rb
#
# Requirements:
# - Ruby
#

def up_or_down(word, condition)
  up_or_down = condition ? :upcase : :downcase
  word.send(up_or_down)
end

p up_or_down('Ruby', true)
p up_or_down('Ruby', false)

