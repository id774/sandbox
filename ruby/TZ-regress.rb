# TZ-regress.rb: Localize a time with an explicit offset under TZ=JST-9
#
# Description:
# Parse a time carrying an explicit offset under TZ=JST-9 and localize it.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby TZ-regress.rb
#
# Requirements:
# - Ruby
#

require 'time'

ENV['TZ'] = 'JST-9'
p Time.parse("2014-12-29 20:16:32 -0400")
p Time.parse("2014-12-29 20:16:32 -0400").localtime
