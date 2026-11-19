#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-
# mapper.rb: Hadoop Streaming mapper counting RSSI events
#
# Description:
# Emit one count per RSSI event keyed by source file and MAC address, reading
# JSON records from standard input.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     cat <input> | ruby lib/mapper.rb | sort | ruby lib/reducer.rb
#
# Requirements:
# - Ruby
#

require 'json'

$:.unshift File.join(File.dirname(__FILE__))

class Mapper
  def self.map(stdin)
    event_type = mac_str = tar_file = ""

    stdin.each_line {|line|
      json = line.force_encoding("utf-8").strip
      JSON.parse(json).each {|k,v|
        event_type = v if k == "event_type"
        mac_str = v if k == "mac_str"
        tar_file = v if k == "tar_file"
      }
      if event_type == "rssi"
        puts "#{tar_file},#{mac_str}\t1\n" unless mac_str == ""
      end
      event_type = mac_str = tar_file = ""
    }
  end
end

if __FILE__ == $0
  Mapper.map($stdin)
end
