#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# args.rb: Collect arguments into a splat parameter
#
# Description:
# Collect every argument into a splat parameter.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby args.rb
#
# Requirements:
# - Ruby
#

def hoge1(*args)
  args.each_index{|i|
    puts "args[#{i}]=#{args[i]}"
  }
end

hoge1('hello', 'my', 'friend')
