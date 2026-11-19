#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# args2.rb: Required, optional, and splat parameters
#
# Description:
# Combine required, optional, and splat parameters, then splat an array into
# them.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby args2.rb
#
# Requirements:
# - Ruby
#

def hoge2(arg1, arg2 = '', *args)
  puts "arg1=#{arg1}"
  puts "arg2=#{arg2}"
  args.each_index{|i|
    puts "args[#{i}]=#{args[i]}"
  }
end

hoge2('hello', 'my', 'friend', '!')

array = ['hello', 'my', 'friend', '!']
hoge2(*array)
