#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-
# reducer.rb: Add readable times and gaps to job1 records
#
# Description:
# Add a human readable time and the gap since the previous record to each
# sorted record from standard input.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     cat test_data.txt | ruby lib/mapper.rb | sort | ruby lib/reducer.rb
#
# Requirements:
# - Ruby
#

$:.unshift File.join(File.dirname(__FILE__))

class Reducer
  def self.reduce(stdin)
    time_diff = current_time = -1
    key = newkey = event_type = mac_str = tar_file = timestamp = rmac_str = rssi_val = humantime = ""

    stdin.each_line {|line|
      k, rmac_str, rssi_val = line.strip.split("\t")
      tar_file, mac_str, timestamp = k.strip.split(",")

      newkey = tar_file + mac_str
      humantime = Time.at(timestamp.to_i).to_s

      if key == newkey
        time_diff = timestamp.to_i - current_time
        puts "#{tar_file}\t#{mac_str}\t#{rmac_str}\t#{rssi_val}\t#{timestamp}\t#{humantime}\t#{time_diff}\n"
      else
        time_diff = -1
        puts "#{tar_file}\t#{mac_str}\t#{rmac_str}\t#{rssi_val}\t#{timestamp}\t#{humantime}\t#{time_diff}\n"
        key = newkey
        newkey = ""
      end
      current_time = timestamp.to_i
    }
  end
end

if __FILE__ == $0
  Reducer.reduce($stdin)
end
