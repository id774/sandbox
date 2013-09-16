require 'sidekiq'

class HardWorker
  include Sidekiq::Worker

  def perform(name, count)
    puts 'Doing hard work'
  end
end

HardWorker.perform_async('bob', 5)
