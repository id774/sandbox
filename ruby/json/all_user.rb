# -*- coding: utf-8 -*-

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

