require 'time'

ENV['TZ'] = 'JST-9'
p Time.parse("2014-12-29 20:16:32 -0400")
p Time.parse("2014-12-29 20:16:32 -0400").localtime
