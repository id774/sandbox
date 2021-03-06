# -*- coding: utf-8 -*-

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

