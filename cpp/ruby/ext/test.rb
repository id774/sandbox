# test.rb: Call the hello extension from Ruby
#
# Description:
# Load the compiled hello extension and call Hello#say_hello.
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
# - The hello extension built in this directory with extconf.rb and make
#

require "./hello"

Hello.new.say_hello
