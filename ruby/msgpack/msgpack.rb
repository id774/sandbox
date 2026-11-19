#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# msgpack.rb: MessagePack round trip of an array
#
# Description:
# Pack an array with MessagePack and unpack it again.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby msgpack.rb
#
# Requirements:
# - Ruby
# - The msgpack gem
#

require "msgpack"
msg = [1,2,3].to_msgpack  #=> "\x93\x01\x02\x03"
p msg
p MessagePack.unpack(msg)   #=> [1,2,3]
