# -*- coding: utf-8 -*-
# extract_title_from_json.rb: Title field of every JSON record
#
# Description:
# Collect the title field from every JSON record in a log, json.txt by
# default.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby extract_title_from_json.rb [log file]
#
# Requirements:
# - Ruby
# - The awesome_print gem
#

require 'json'
require 'awesome_print'

class Extractor
  def initialize(args)
    @filename = args.shift || "json.txt"
  end

  def get_title
    arr = Array.new
    open(@filename) do |file|
      file.each_line do |line|
        key, tag, json = line.force_encoding("utf-8").strip.split("\t")
        JSON.parse(json).each {|key, value|
          arr << value if key == 'title'
        }
      end
    end

    arr
  end
end

if __FILE__ == $0
  extractor = Extractor.new(ARGV)
  result = extractor.get_title
  ap result
end

