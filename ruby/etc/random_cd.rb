#!/usr/bin/env ruby
# random_cd.rb: Random four-digit strings
#
# Description:
# Print several random four digit strings.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby random_cd.rb
#
# Requirements:
# - Ruby
#

4.times do
  puts "#{[*0..9].sample(4).join}"
end
