# em_defer_callback.rb: Deferred result handed to a callback
#
# Description:
# Hand the result of a deferred operation to a callback.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby em_defer_callback.rb
#
# Requirements:
# - Ruby with the eventmachine gem
#

require 'eventmachine'

EM.run do
  op = proc do
    2+2
  end
  callback = proc do |count|
    puts "2 + 2 == #{count}"
    EM.stop
  end
  EM.defer(op, callback)
end
