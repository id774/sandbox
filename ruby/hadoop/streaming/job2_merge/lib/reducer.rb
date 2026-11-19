#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-
# reducer.rb: Split the job2 composite key
#
# Description:
# Split the composite key back into file and timestamp columns, reading sorted
# records from standard input.
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

$:.unshift File.join(File.dirname(__FILE__))

class Reducer
  def self.reduce(stdin)
    key = newkey = ""

    stdin.each_line {|line|
      key, mac_str, rmac_str, rssi_val, humantime, time_diff = line.strip.split("\t")
      tar_file, timestamp = key.split(",")
      puts "#{tar_file}\t#{timestamp}\t#{mac_str}\t#{rmac_str}\t#{rssi_val}\t#{humantime}\t#{time_diff}\n"
    }
  end
end

if __FILE__ == $0
  Reducer.reduce($stdin)
end
