# -*- coding: utf-8 -*-
# multiply.rb: Call a two-argument lambda
#
# Description:
# Call a two argument lambda.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby multiply.rb
#
# Requirements:
# - Ruby
#

multiply = lambda {|x, y| x * y }

p multiply.call(20, 3)
p multiply.call(10, 5)

