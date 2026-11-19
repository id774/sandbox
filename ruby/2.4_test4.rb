# 2.4_test4.rb: Parse times with a zone name and an offset
#
# Description:
# Parse times given with a zone name and with an explicit offset.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby 2.4_test4.rb
#
# Requirements:
# - Ruby 2.4 or later
#

require 'date'
cet_date_time = DateTime.strptime('2015-11-12 CET', '%Y-%m-%d %Z')
p cet_date_time.to_time.to_s

cet_time = Time.new(2005, 2, 21, 10, 11, 12, '+01:00')
p cet_time.to_time.to_s
