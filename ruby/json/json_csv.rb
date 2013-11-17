#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'csv'
require 'json'

class Converter
  def initialize(args)
    @filename = args.shift || "json.txt"
    @headers = []
  end

  def start
    open(@filename) do |file|
      file.each_line do |line|
        key, tag, json = line.force_encoding("utf-8").strip.split("\t")
        hash = JSON.parse(json)

        if @headers.length == 0
          @headers = ['key', 'tag']
          @headers.concat(hash.keys)
          output(@headers)
        end

        row = [key, tag]
        row.concat(hash.values)
        output(row)
      end
    end
  end

  private

  def output(array)
    puts array.join("\t")
  end

end

if __FILE__ == $0
  converter = Converter.new(ARGV)
  converter.start
end
