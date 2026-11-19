# em_timers_class.rb: EventMachine Timer and PeriodicTimer classes
#
# Description:
# Combine a one shot timer with a periodic timer through the Timer and
# PeriodicTimer classes.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby em_timers_class.rb
#
# Requirements:
# - Ruby with the eventmachine gem
#

require 'eventmachine'

EM.run do
  EM::Timer.new(5) do
    puts "BOOM"
    EM.stop
  end
  EM::PeriodicTimer.new(1) do
    puts "Tick ..."
  end
end
