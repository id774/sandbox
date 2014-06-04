#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-

require 'json'

$:.unshift File.join(File.dirname(__FILE__))

class Mapper
  def self.map(stdin)
    event_type = mac_str = tar_file = device_type = rmac_str = ""

    stdin.each_line {|line|
      json = line.force_encoding("utf-8").strip
      JSON.parse(json).each {|k,v|
        event_type = v if k == "event_type"
        mac_str = v if k == "mac_str"
        rmac_str = v if k == "rmac_str"
        tar_file = v if k == "tar_file"
      }
      if event_type == "rssi"
        puts "#{mac_str},#{tar_file}\t#{json}\n" unless mac_str == ""
      end
      event_type = mac_str = tar_file = device_type = rmac_str = ""
    }
  end
end

if __FILE__ == $0
  Mapper.map($stdin)
end
