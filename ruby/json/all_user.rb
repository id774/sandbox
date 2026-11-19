# -*- coding: utf-8 -*-
# all_user.rb: Owning user of every activity record
#
# Description:
# Print the owning user of every activity record in a JSON log, all.txt by
# default.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby all_user.rb [log file]
#
# Requirements:
# - Ruby
#

require 'json'

class Analyzer
  def initialize(args)
    @filename = args.shift || "all.txt"
  end

  def classify
    open(@filename) do |file|
      file.each_line do |line|
        key, tag, json = line.force_encoding("utf-8").strip.split("\t")

        code, type, project_name = key.strip.split(",")
        action, result = tag.strip.split(",")

        if type == "activity"
          hash = JSON.parse(json)
          user_id = hash["自社担当者ユーザID"]

          output(user_id, tag, json)
        end
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
  analyzer.classify
end

