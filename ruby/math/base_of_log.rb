#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-
# base_of_log.rb: Base change of a logarithm
#
# Description:
# Print log base 2 of 10, computed as a ratio of natural logarithms.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby base_of_log.rb
#
# Requirements:
# - Ruby
#

# Find the base of a logarithm
p Math.log(10.0) / Math.log(2.0)
