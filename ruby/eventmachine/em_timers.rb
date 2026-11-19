# em_timers.rb: One-shot and periodic EventMachine timers
#
# Description:
# Combine a one shot timer with a periodic timer.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby em_timers.rb
#
# Requirements:
# - Ruby with the eventmachine gem
#

require 'eventmachine'

EM.run do
  EM.add_timer(5) do
    puts "BOOM"
    EM.stop_event_loop
  end
  EM.add_periodic_timer(1) do
    puts "Tick ... "
  end
end
