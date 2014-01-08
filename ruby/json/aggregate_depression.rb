# -*- coding: utf-8 -*-

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

