# -*- coding: utf-8 -*-
# dataclips2csv.rb: First column of a Dataclips JSON export
#
# Description:
# Print the first column of every row in a Dataclips JSON export, json.txt by
# default.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby dataclips2csv.rb [JSON file]
#
# Requirements:
# - Ruby
# - The awesome_print gem
#

require 'json'
require 'awesome_print'

class Analyzer
  def initialize(args)
    @filename = args.shift || "json.txt"
    @hash = Hash.new
  end

  def start
    json = File.read(@filename, :encoding => Encoding::UTF_8)
    JSON.parse(json).each {|key, values|
      values.each {|value|
        puts value[0]
      }
    }
  end
end

if __FILE__ == $0
  analyzer = Analyzer.new(ARGV)
  analyzer.start
end

