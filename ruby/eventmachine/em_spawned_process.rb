# em_spawned_process.rb: Messages to a spawned EventMachine process
#
# Description:
# Send messages to a spawned EventMachine process.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby em_spawned_process.rb
#
# Requirements:
# - Ruby with the eventmachine gem
#

require 'eventmachine'

EM.run do
  s = EM.spawn do |val|
    puts "Received #{val}"
  end

  EM.add_timer(1) do
    s.notify "hello"
  end
  EM.add_periodic_timer(1) do
    puts "Periodic"
  end
  EM.add_timer(3) do
    EM.stop
  end
end
