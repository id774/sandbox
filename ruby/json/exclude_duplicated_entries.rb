# -*- coding: utf-8 -*-
# exclude_duplicated_entries.rb: Drop records with an already seen link
#
# Description:
# Drop the records whose link has already been seen in a JSON log, json.txt by
# default.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby exclude_duplicated_entries.rb [log file]
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
    @links = []
  end

  def exclude
    arr = Array.new
    open(@filename) do |file|
      file.each_line do |line|
        key, tag, json = line.force_encoding("utf-8").strip.split("\t")
        hash = JSON.parse(json)
        unless @links.include?(hash['link'])
          puts "#{line}"
          @links << hash['link']
        end
      end
    end

    arr
  end
end

if __FILE__ == $0
  extractor = Extractor.new(ARGV)
  extractor.exclude
end

