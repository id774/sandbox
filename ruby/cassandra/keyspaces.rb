#!/opt/ruby/1.9.3/bin/ruby
# -*- coding: utf-8 -*-

require 'rubygems'
require 'cassandra'
include Cassandra::Constants

client = Cassandra.new("Keyspace1", "127.0.0.1:9160")

p client.keyspaces
