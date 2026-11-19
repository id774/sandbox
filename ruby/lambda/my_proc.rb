# -*- coding: utf-8 -*-
# my_proc.rb: Pass a lambda to a method as a block
#
# Description:
# Pass a lambda into a method as a block and call it with arguments.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby my_proc.rb
#
# Requirements:
# - Ruby
#

def run_it_with_param(&block)
  puts("Before the call.")
  block.call(20)
  block.call(10)
  puts("After the call.")
end

my_proc = lambda {|x| puts ("The value of x is #{x}") }
run_it_with_param(&my_proc)

