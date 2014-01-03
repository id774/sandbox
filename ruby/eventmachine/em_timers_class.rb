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
