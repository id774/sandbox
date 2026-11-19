#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# numeric.rb: Integer passed as a block through Numeric#to_proc
#
# Description:
# Give Numeric a to_proc so an integer can be passed as a block.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby numeric.rb
#
# Requirements:
# - Ruby
#

class Numeric
  def to_proc
    if self == 1 then lambda {|x| x}
    else raise
    end
  end
end

p [1,2,3].map(&1)
