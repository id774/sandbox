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
