#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'csv'
require 'json'

class Converter
  def initialize(args)
    @filename = args.shift || "json.txt"
  end

  def start
    open(@filename) do |file|
      headers = []
      file.each_line do |line|
        json = line.force_encoding("utf-8").strip
        hash = JSON.parse(json)

        if headers.length == 0
          headers.concat(hash.keys)
          output(headers)
        end

        row = []
        row.concat(hash.values)
        output(row)
      end
    end
  end

  private

  def output(array)
    puts array.join(",")
  end
end

if __FILE__ == $0
  converter = Converter.new(ARGV)
  converter.start
end
