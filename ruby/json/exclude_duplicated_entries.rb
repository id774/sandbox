# -*- coding: utf-8 -*-

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

