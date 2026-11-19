# generate_mac_address.rb: Random MAC address as a C byte array
#
# Description:
# Print a random MAC address as a C byte array.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby generate_mac_address.rb
#
# Requirements:
# - Ruby
#

print "byte mac_address[] = { "
6.times do |i|
    print "0x" + rand(255).to_s(16) + (i >= 5 ? " };" : ", ")
end

