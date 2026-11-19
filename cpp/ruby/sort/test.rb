# test.rb: Call the sort extension from Ruby
#
# Description:
# Load the compiled sort extension, create a Sort, and print the result of
# greet.
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
# - The sort extension built in this directory with extconf.rb and make
#

require "./sort"

h = Sort.new("Taro")
puts h.greet

