# em_periodictimer.rb: Cancel a periodic timer from a one-shot timer
#
# Description:
# Cancel a periodic timer from a one shot timer.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby em_periodictimer.rb
#
# Requirements:
# - Ruby with the eventmachine gem
#

require 'eventmachine'

EM.run do
  p = EM::PeriodicTimer.new(1) do
    puts "Tick ..."
  end

  EM::Timer.new(5) do
    puts "BOOM"
    p.cancel
  end

  EM::Timer.new(8) do
    puts "The googles, they do nothing"
    EM.stop
  end
end
