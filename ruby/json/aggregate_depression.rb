# -*- coding: utf-8 -*-
# aggregate_depression.rb: Classification of each record in a JSON log
#
# Description:
# Print the classification of each record in a tab separated JSON log,
# json.txt by default.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby aggregate_depression.rb [log file]
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
    open(@filename) do |file|
      file.each_line do |line|
        key, tag, value = line.force_encoding("utf-8").strip.split("\t")
        json = JSON.parse(value)
        id, code, activity, project_name, type, success = key.split(",")
        classify, score = tag.split(",")
        output(id, success, classify)
      end
    end
  end

  private

  def output(key, tag, value)
    puts "#{key}\t#{tag}\t#{value}"
  end
end

if __FILE__ == $0
  analyzer = Analyzer.new(ARGV)
  analyzer.start
end

