# -*- coding: utf-8 -*-
# fluent-logger_sample.rb: Post a record to fluentd
#
# Description:
# Post a record to fluentd with fluent-logger.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby fluent-logger_sample.rb
#
# Requirements:
# - Ruby
# - The fluent-logger gem
# - A fluentd listener
#

require 'fluent-logger'

@fluentd = Fluent::Logger::FluentLogger.open(nil,
  host = '133.242.144.202',
  port = 3000)
@fluentd.post('rspec.debug.forward', {"hoge" => "fuga"})

