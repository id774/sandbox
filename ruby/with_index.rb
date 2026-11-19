# with_index.rb: each.with_index starting at 1
#
# Description:
# Iterate with each.with_index starting the index at 1.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby with_index.rb
#
# Requirements:
# - Ruby
#

%w(杏子 さやか マミ).each.with_index(1) do |element, i|
  puts "#{i} #{element}"
end
