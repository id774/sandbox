# test.rb: Call the test1 method of the mytest extension
#
# Description:
# Load the compiled mytest extension and call its test1 method, printing the
# returned value.
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
# - The mytest extension built in this directory with extconf.rb and make
#

require "./mytest"
include MyTest
puts test1
