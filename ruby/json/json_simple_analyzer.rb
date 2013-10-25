# -*- coding: utf-8 -*-

require 'json'
require 'awesome_print'

class Analyzer
  def initialize(filename)
    @filename = filename
    @hash = Hash.new
  end

  def start
    open(@filename) do |file|
      file.each_line do |line|
        key, tag, json = line.force_encoding("utf-8").strip.split("\t")
        id, process, result = key.strip.split(",")
        JSON.parse(json).each {|word, count|
          @hash.has_key?(word) ? @hash[word] += 1 : @hash[word] = 1
        }
      end
    end
    ap Hash[@hash.sort_by{|k, v| -v}]
  end
end

if __FILE__ == $0
  filename = ARGV.shift || "json.txt"
  analyzer = Analyzer.new(filename)
  analyzer.start
end

