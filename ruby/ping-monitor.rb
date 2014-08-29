# -*- coding: utf-8 -*-

require 'net/ping'

def monitor(args)
  r_code = 0
  hosts = args || []

  hosts.each do |host|
    ping = Net::Ping::External.new(
      host = host, timeout = 5
    )

    unless ping.ping?
      puts "#{host} unreachable."
      r_code = 1
    end
  end

  exit r_code
end

if __FILE__ == $0
  monitor(ARGV)
end

