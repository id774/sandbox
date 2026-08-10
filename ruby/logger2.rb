# Redefine puts to route messages through a logger.

require 'logger'

def logger
  @logger ||= Logger.new(STDOUT)
end

def puts(msg, level = :info)
  logger.send level, msg
end

puts("ほげ")
