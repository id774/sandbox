# 3-dimension.rb: Index and slice a three-dimensional NArray
#
# Description:
# Index and slice a three dimensional NArray.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby 3-dimension.rb
#
# Requirements:
# - Ruby
# - The narray gem
#

require 'narray'

na = NArray.int(3,2,2).indgen!(1,1)

p na

p na[0,0,0]
p na[0,1,0]
p na[0,0,1]

p na[true, true, 0]
p na[true, true, 0].sum
p na[true, 0, true]
p na[true, 0, true].sum
