# -*- coding: utf-8 -*-
# array2json_lines.rb: One JSON object per nested array
#
# Description:
# Emit one JSON object per nested array.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby array2json_lines.rb
#
# Requirements:
# - Ruby
#

require 'json'

multi_array = [["test01", "test04"], ["test02"], ["test03", "test05"], ["test06"], []]
multi_array.each {|array|
  hash = {}
  array.each {|word|
    hash[word] = 1
  }
  json = JSON.generate(hash)
  puts json
}

