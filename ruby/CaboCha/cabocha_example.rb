# -*- coding: utf-8 -*-
# cabocha_example.rb: CaboCha dependency parse in several forms
#
# Description:
# Print the CaboCha dependency parse of a sentence in several forms.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby cabocha_example.rb
#
# Requirements:
# - Ruby
# - CaboCha with its Ruby binding
#

require 'CaboCha'
cabocha = CaboCha::Parser.new('--charset=UTF8')
sent = "太郎はこの本を二郎を見た女性に渡した。"

puts "--- puts sent ---"
puts sent

puts "--- puts cabocha.parseToString(sent) ---"
puts cabocha.parseToString(sent)

tree = cabocha.parse(sent)

puts "--- puts tree.toString(0) ---"
puts tree.toString(0)
puts "--- puts tree.toString(1) ---"
puts tree.toString(1)
puts "--- puts tree.toString(2) ---"
puts tree.toString(2)
puts "--- puts tree.toString(3) ---"
puts tree.toString(3)
puts "--- puts tree.toString(4) ---"
puts tree.toString(4)
puts "--- puts tree.toString(5) ---"
puts tree.toString(5)

