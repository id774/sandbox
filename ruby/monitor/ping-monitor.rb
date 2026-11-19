# -*- coding: utf-8 -*-
# ping-monitor.rb: Ping hosts and report failures
#
# Description:
# Ping every host given as an argument and report the failures.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby ping-monitor.rb <host>...
#
# Requirements:
# - Ruby
# - The net-ping gem
#

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

