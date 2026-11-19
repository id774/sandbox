# test.rb: Call the human extension from Ruby
#
# Description:
# Load the compiled human extension, create a Human, and print its greeting.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby test.rb
#
# Requirements:
# - Ruby
# - The human extension built in this directory with extconf.rb and make
#

require "./human"

h = Human.new("Taro", 18)
puts h.greet

