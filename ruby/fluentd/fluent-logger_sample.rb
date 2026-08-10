# -*- coding: utf-8 -*-
# Post a record to fluentd with fluent-logger.

require 'fluent-logger'

@fluentd = Fluent::Logger::FluentLogger.open(nil,
  host = '133.242.144.202',
  port = 3000)
@fluentd.post('rspec.debug.forward', {"hoge" => "fuga"})

