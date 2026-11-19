# em_defer.rb: EventMachine thread pool work with defer
#
# Description:
# Run work on the EventMachine thread pool with defer.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby em_defer.rb
#
# Requirements:
# - Ruby with the eventmachine gem
#

require 'eventmachine'
require 'thread'

EM.run do
  EM.add_timer(2) do
    puts "Main #{Thread.current}"
    EM.stop_event_loop
  end
  EM.defer do
    puts "Defer #{Thread.current}"
  end
end
