#!/usr/bin/env ruby
# upper.rb: Rewrite a file in upper case through a temporary file
#
# Description:
# Rewrite foo.txt in the current directory in upper case through a temporary
# file.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby upper.rb
#
# Requirements:
# - Ruby
# - foo.txt in the current directory
#

require 'tempfile'

temp = Tempfile::new("foobar")

open("foo.txt") {|f|
  f.each {|line|
    line.upcase!
    temp.puts(line)
  }
}

temp.close
temp.open

open("foo.txt", "w") {|f| temp.each {|line| f.puts(line) }}

temp.close(true)
