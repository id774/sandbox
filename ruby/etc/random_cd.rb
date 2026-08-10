#!/usr/bin/env ruby
# Print several random four digit strings.

4.times do
  puts "#{[*0..9].sample(4).join}"
end
