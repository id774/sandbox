#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# flat_scope.rb: Capture a local variable with Class.new and define_method
#
# Description:
# Capture a local variable inside Class.new and define_method.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby flat_scope.rb
#
# Requirements:
# - Ruby
#

my_var = "Success"

MyClass = Class.new do
  puts "Class: #{my_var}"

  define_method :my_method do
    puts "Method: #{my_var}"
  end

end

myclass = MyClass.new
myclass.my_method

