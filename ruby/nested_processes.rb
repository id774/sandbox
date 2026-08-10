#!/usr/bin/ruby
# Fork a child process and print both process ids.

fork {
  puts "Child process pid is #{Process.pid}"
  sleep 3600
}

puts "Parent process pid is #{Process.pid}"
sleep 3600

