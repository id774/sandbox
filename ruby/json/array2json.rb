# -*- coding: utf-8 -*-
# array2json.rb: Nested arrays to one JSON object keyed by word
#
# Description:
# Turn nested arrays into one JSON object keyed by word.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby array2json.rb
#
# Requirements:
# - Ruby
#

require 'json'

multi_array = [["test01", "test04"], ["test02"], ["test03", "test05"], ["test06"], []]
i = 0
hash = {}
multi_array.each {|array|
  array.each {|word|
    hash[word] = i
  }
  i += 1
}
json = JSON.generate(hash)
puts json

