# em_deferable.rb: Callback on an EM::Deferrable object
#
# Description:
# Fire a callback on an object that includes EM::Deferrable.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby em_deferable.rb
#
# Requirements:
# - Ruby with the eventmachine gem
#

require 'eventmachine'

class MyDeferrable
  include EM::Deferrable
  def go(str)
    puts "Go #{str} go"
  end
end

EM.run do
  df = MyDeferrable.new
  df.callback do |x|
    df.go(x)
    EM.stop
  end
  EM.add_timer(1) do
    df.set_deferred_status :succeeded, "SpeedRacer"
  end
end
