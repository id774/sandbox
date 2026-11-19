#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# punctuation.rb: Random string of commas and periods
#
# Description:
# Build a string of randomly chosen commas and periods.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby punctuation.rb
#
# Requirements:
# - Ruby
#

def yuyu_punctuation(length)
  comma = "、"
  period = "。"
  sentence = ""
  (rand(length)+1).times do
    rand(2) == 0 ? sentence << comma : sentence << period
  end
  sentence
end

if __FILE__ == $0
  puts yuyu_punctuation(10)
end
