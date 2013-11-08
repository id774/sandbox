#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'json'
require 'time'
require 'fluent-logger'


class Converter
  def initialize(args)
    @filename = args.shift || "param.txt"
    @hostname = args.shift || "localhost"
    @port     = args.shift || "9999"
    @prefix   = args.shift || "debug"
    @suffix   = args.shift || "test"

    @fluentd = Fluent::Logger::FluentLogger.open(@prefix,
      host = @hostname, port = @port.to_i)
  end

  def start
    open(@filename) do |file|
      file.each do |line|
        row = line.force_encoding("utf-8")
        row_time = row.scan(/\[.*\]/)[0]
        if row_time.nil?
          timestamp = Time.now
        else
          row_time.slice!(0)
          begin
            timestamp = Time.parse(row_time.split(" ")[0])
          rescue ArgumentError
            timestamp = Time.now
          end
        end

        values = row.scan(/\{.*\}/)[0].split(",")
        key = values[2]
        unless key.nil?
          key.slice!(0, 20)
          key.chop! unless key.empty?
        end

        value = values[3]
        unless value.nil?
          value.slice!(0, 9)
          value.chop!.chop! unless value.empty?
        end

        unless key.nil? and value.nil?
          @fluentd.post(@suffix, {
            :key => key,
            :value => value,
            :timestamp => timestamp
          })
        end
      end
    end
  end
end

if __FILE__ == $0
  filename = ARGV.shift || "param.txt"
  hostname = ARGV.shift || "localhost"
  port     = ARGV.shift || "9999"
  prefix   = ARGV.shift || "debug"
  suffix   = ARGV.shift || "test"
  converter = Converter.new(filename, hostname, port, prefix, suffix)
  converter.start
end
