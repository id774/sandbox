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
        key, tag, json = line.force_encoding("utf-8").strip.split("\t")
        JSON.parse(json).each {|word, count|
          @hash.has_key?(word) ? @hash[word] += count : @hash[word] = count
        }
      end
    end

    i = 0
    @hash.sort_by{|k, v| -v}.each {|k, v|
      i += 1
      output(i, k, v)
    }
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

