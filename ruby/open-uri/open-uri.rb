#!/usr/bin/env ruby
# open-uri.rb: Read a web page line by line with open-uri
#
# Description:
# Read a web page line by line with open-uri.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby open-uri.rb
#
# Requirements:
# - Ruby before 3.0, whose Kernel#open still opens URLs through open-uri
# - Network access to the page in the source
#

require 'open-uri'
open("http://blog.id774.net/post/") do |f|
  f.each do |line|
    puts line
  end
end
