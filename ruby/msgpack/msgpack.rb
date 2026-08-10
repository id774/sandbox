#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# Pack an array with MessagePack and unpack it again.

require "msgpack"
msg = [1,2,3].to_msgpack  #=> "\x93\x01\x02\x03"
p msg
p MessagePack.unpack(msg)   #=> [1,2,3]
