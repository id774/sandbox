# -*- coding: utf-8 -*-

require 'fluent-logger'

@fluentd = Fluent::Logger::FluentLogger.open(nil,
  host = '133.242.144.202',
  port = 3000)
@fluentd.post('rspec.debug.forward', {"hoge" => "fuga"})

