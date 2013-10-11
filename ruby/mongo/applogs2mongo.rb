#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'json'
require 'time'
require 'fluent-logger'
#require 'awesome_print'

@fluentd = Fluent::Logger::FluentLogger.open('vocabulary',
  host = 'localhost', port = 9999)

open("param.txt") do |file|
  file.each do |line|
    row = line.force_encoding("utf-8")
    row_time = row.scan(/\[.*\]/)[0]
    row_time.slice!(0)
    timestamp = Time.parse(row_time.split(" ")[0])

    records = row.scan(/\{.*\}/)[0].split(",")
    key = records[2]
    key.slice!(0, 20)
    key.chop! unless key.empty?

    tag = records[3]
    tag.slice!(0, 9)
    tag.chop!.chop! unless tag.empty?

    @fluentd.post('applogs', {
      :key => key,
      :tag => tag,
      :timestamp => timestamp
    })

  end
end
