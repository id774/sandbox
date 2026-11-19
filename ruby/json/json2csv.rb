#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# json2csv.rb: JSON lines to CSV
#
# Description:
# Convert JSON lines into CSV, taking the header from the first record. The
# input defaults to json.txt.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby json2csv.rb [JSON lines file]
#
# Requirements:
# - Ruby
#

require 'csv'
require 'json'

class Converter
  def initialize(args)
    @filename = args.shift || "json.txt"
  end

  def start
    open(@filename) do |file|
      headers = []
      file.each_line do |line|
        json = line.force_encoding("utf-8").strip
        hash = JSON.parse(json)

        if headers.length == 0
          headers.concat(hash.keys)
          output(headers)
        end

        row = []
        row.concat(hash.values)
        output(row)
      end
    end
  end

  private

  def output(array)
    puts array.join(",")
  end
end

if __FILE__ == $0
  converter = Converter.new(ARGV)
  converter.start
end
