#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# thx4followback.rb: Reply string from random fragments
#
# Description:
# Build a reply string by repeating randomly chosen fragments.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby thx4followback.rb
#
# Requirements:
# - Ruby
#

f = "フォロバ"
o = "乙"
a = "あり"
d = "ですー"
s = ""
s << f

rand(100).times do
  if rand(2) == 0
    s << o
  else
    s << a
  end
end

s << d
p s
