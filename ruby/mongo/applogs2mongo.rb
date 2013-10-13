#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'json'
require 'time'
require 'fluent-logger'


class Converter
  def initialize(filename, hostname, port, prefix, tag)
    @filename = filename
    @tag      = tag
    @fluentd = Fluent::Logger::FluentLogger.open(prefix,
      host = hostname, port = port.to_i)
  end

  def start
    open(@filename) do |file|
      file.each do |line|
        row = line.force_encoding("utf-8")
        row_time = row.scan(/\[.*\]/)[0]
        row_time.slice!(0)
        timestamp = Time.parse(row_time.split(" ")[0]) || Time.now

        values = row.scan(/\{.*\}/)[0].split(",")
        key = values[2]
        key.slice!(0, 20)
        key.chop! unless key.empty?

        tag = values[3]
        tag.slice!(0, 9)
        tag.chop!.chop! unless tag.empty?

        @fluentd.post(@tag, {
          :key => key,
          :tag => tag,
          :timestamp => timestamp
        })
      end
    end
  end
end

if __FILE__ == $0
  filename = ARGV.shift || "param.txt"
  hostname = ARGV.shift || "localhost"
  port     = ARGV.shift || "9999"
  prefix   = ARGV.shift || "debug"
  tag      = ARGV.shift || "test"
  converter = Converter.new(filename, hostname, port, prefix, tag)
  converter.start
end
