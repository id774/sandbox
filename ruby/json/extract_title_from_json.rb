# -*- coding: utf-8 -*-

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

