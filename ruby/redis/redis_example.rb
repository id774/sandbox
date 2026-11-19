# redis_example.rb: Set and get a key on a local Redis server
#
# Description:
# Set and get a key on a local Redis server.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby redis_example.rb
#
# Requirements:
# - Ruby
# - The redis gem and a Redis server on localhost
#

require 'redis'
r = Redis.new
p r.ping
p r.set('foo','bar')
p r.get('foo')
