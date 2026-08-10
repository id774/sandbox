# Set and get a key on a local Redis server.

require 'redis'
r = Redis.new
p r.ping
p r.set('foo','bar')
p r.get('foo')
