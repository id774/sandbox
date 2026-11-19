#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# args3.rb: Merge an options hash over defaults
#
# Description:
# Take options as a hash and merge them over a set of defaults.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby args3.rb
#
# Requirements:
# - Ruby
#

def hoge3(arg1, options={})
  values = {'name' => 'anonymous', 'sex' => 'not known'}
  values.merge!(options)
  puts "arg1=#{arg1}"
  values.each{|k,v|
    puts "#{k}=#{v}"
  }
end

hoge3('hello', { 'name' => 'Alice' })
hoge3('hello', 'name' => 'Alice', 'sex' => 'Female', 'age' => 12)
