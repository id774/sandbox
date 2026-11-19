# netping.rb: Ping one address and report the result
#
# Description:
# Ping one address and report whether it answered.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby netping.rb
#
# Requirements:
# - Ruby
# - The net-ping gem
#

require 'net/ping'
 
addr = '172.16.xxx.xxx'
 
pingmon = Net::Ping::External.new(
  host = addr,
  timeout = 5
)

if pingmon.ping?
  puts 'reachable.'
else
  puts 'unreachable.'
end
