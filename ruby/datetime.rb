#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

# Date
require 'date'
datetime = Date.strptime("2012-10-15-11:10:15", "%Y-%m-%d-%H:%M:%S")
p datetime.strftime("%Y-%m-%d %H:%M:%S")
p datetime.to_s

datetime += 1
p datetime.to_s

# Time
datetime = Time.local(2012, 10, 15, 11, 10, 15)
p datetime.strftime("%Y-%m-%d %H:%M:%S")
p datetime.to_s

datetime += 1
p datetime.to_s
