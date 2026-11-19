# em_next_tick.rb: Work scheduled on the next event loop tick
#
# Description:
# Schedule work on the next tick of the event loop.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby em_next_tick.rb
#
# Requirements:
# - Ruby with the eventmachine gem
#

require 'eventmachine'

EM.run do
  EM.add_periodic_timer(1) do
    puts "Hai"
  end
  EM.add_timer(5) do
    EM.next_tick do
      EM.stop_event_loop
    end
  end
end
