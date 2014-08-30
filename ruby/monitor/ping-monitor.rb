# -*- coding: utf-8 -*-

require 'net/ping'

def monitor(args)
  rc = 0
  hosts = args || []

  hosts.each do |host|
    ping = Net::Ping::External.new(
      host = host, timeout = 5
    )

    unless ping.ping?
      puts "#{host} unreachable."
      rc = 1
    end
  end

  exit rc
end

if __FILE__ == $0
  monitor(ARGV)
end

