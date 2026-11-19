# sum.rb: Row and column sums of an NArray
#
# Description:
# Sum the rows and columns of an NArray.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby sum.rb
#
# Requirements:
# - Ruby
# - The narray gem
#

require 'narray'

na = NArray.int(3,3).indgen!(1,1)

p na
p na.class

p na[true, 1]

p na[true, 1].sum

p na[0, true]
p na[0, true].sum

p na[true, [0, 1]]
p na[true, [0, 1]].sum(0)
p na[true, [0, 1]].sum(1)
p na[true, [0, 1]].sum
