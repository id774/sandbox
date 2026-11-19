#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# csv_json.rb: CSV rows to tab-separated JSON records
#
# Description:
# Convert a CSV file into one tab separated JSON record per row. The files
# default to data.csv and out.txt.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby csv_json.rb [CSV file] [output file]
#
# Requirements:
# - Ruby
#

require 'csv'
require 'json'

class Converter
  def initialize(args)
    @csv_path = args.shift || "data.csv"
    @filename = args.shift || "out.txt"
  end

  def start
    open(File.join(File.expand_path(@filename)), "w") {|f|
      reader = CSV.open(File.expand_path(@csv_path), 'r')
      headers = reader.shift
      primary_key = headers[0]
      id = 0

      reader.each {|row|
        id += 1
        array = [headers, row].transpose
        hash = Hash[*array.flatten]
        hash[primary_key] = row[0]

        f.write(id.to_s + "\t" +
                @csv_path + "\t" +
                hash.to_json + "\n") unless hash.nil?
      }
    }
  end
end

if __FILE__ == $0
  converter = Converter.new(ARGV)
  converter.start
end
