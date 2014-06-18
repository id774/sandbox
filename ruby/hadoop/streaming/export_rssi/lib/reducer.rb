#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-

require 'json'

$:.unshift File.join(File.dirname(__FILE__))

class Reducer
  def self.reduce(stdin)
    time_diff = current_time = 0
    key = newkey = ""
    event_type = mac_str = tar_file = timestamp = rmac_str = humantime = ""

    stdin.each_line {|line|
      k, rmac_str = line.strip.split("\t")
      tar_file, mac_str, timestamp = k.strip.split(",")
      newkey = tar_file + mac_str
      humantime = Time.at(timestamp.to_i).to_s
      if key == newkey
        time_diff = timestamp.to_i - current_time
        current_time = timestamp.to_i
        puts "#{tar_file}\t#{mac_str}\t#{rmac_str}\t#{timestamp}\t#{humantime}\t#{time_diff}\n"
      else
        current_time = timestamp.to_i
        time_diff = 0
        puts "#{tar_file}\t#{mac_str}\t#{rmac_str}\t#{timestamp}\t#{humantime}\t#{time_diff}\n"
        key = newkey
        newkey = ""
      end
    }
  end
end

if __FILE__ == $0
  Reducer.reduce($stdin)
end
