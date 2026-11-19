# getifaddrs.rb: List eth0 addresses with Socket.getifaddrs
#
# Description:
# List the addresses of eth0 with Socket.getifaddrs.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby getifaddrs.rb
#
# Requirements:
# - Ruby
# - A network interface named eth0
#

require 'socket'
result = Socket.getifaddrs.select{|x| x.name == "eth0"}
p result
