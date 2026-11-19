# -*- coding: utf-8 -*-
# cabocha_parse_example.rb: Walk the CaboCha parse tree
#
# Description:
# Walk the CaboCha parse tree one line at a time.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby cabocha_parse_example.rb
#
# Requirements:
# - Ruby
# - CaboCha with its Ruby binding and the awesome_print gem
#

require 'CaboCha'
require 'awesome_print'

cabocha = CaboCha::Parser.new('--charset=UTF8')

sent = "太郎はこの本を二郎を見た女性に渡した。"
tree = cabocha.parse(sent)

tree.toString(4).force_encoding("utf-8").split("\n").each {|line|
  i = 0
  line.strip.split("\t").each {|element|
    puts "#{i},#{element}"
    i += 1
  }
}

