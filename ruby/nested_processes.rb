#!/usr/bin/ruby
# nested_processes.rb: Fork a child and print both process IDs
#
# Description:
# Fork a child process and print both process ids.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby nested_processes.rb
#
# Requirements:
# - Ruby on a platform that supports fork
#

fork {
  puts "Child process pid is #{Process.pid}"
  sleep 3600
}

puts "Parent process pid is #{Process.pid}"
sleep 3600

