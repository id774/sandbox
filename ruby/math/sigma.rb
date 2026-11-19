#!/opt/ruby/current/bin/ruby
# sigma.rb: Sum of squares over a range with inject
#
# Description:
# Sum the squares over a range with inject.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby sigma.rb
#
# Requirements:
# - Ruby
#

n = 10
r1 = Range.new(1,n,false)

p r1.inject(0) {|result, item| result + item**2}
