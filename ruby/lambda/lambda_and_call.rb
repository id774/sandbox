# -*- coding: utf-8 -*-
# lambda_and_call.rb: Define a lambda and call it
#
# Description:
# Define a lambda and invoke it with call.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby lambda_and_call.rb
#
# Requirements:
# - Ruby
#

hello = lambda {
  puts("Hello, world")
}

hello.call
