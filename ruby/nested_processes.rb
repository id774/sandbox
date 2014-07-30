#!/usr/bin/ruby

fork {
  puts "Child process pid is #{Process.pid}"
  sleep 3600
}

puts "Parent process pid is #{Process.pid}"
sleep 3600

