# hard_worker.rb: Sidekiq worker backed by Redis
#
# Description:
# Define a Sidekiq worker backed by Redis.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Requirements:
# - Ruby
# - The sidekiq gem and a Redis server
#

require 'sidekiq'

class HardWorker
  include Sidekiq::Worker

  def perform(name, count)
    puts 'Doing hard work'
  end
end

HardWorker.perform_async('bob', 5)
