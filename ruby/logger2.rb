# logger2.rb: Route puts through a logger
#
# Description:
# Redefine puts to route messages through a logger.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby logger2.rb
#
# Requirements:
# - Ruby
#

require 'logger'

def logger
  @logger ||= Logger.new(STDOUT)
end

def puts(msg, level = :info)
  logger.send level, msg
end

puts("ほげ")
