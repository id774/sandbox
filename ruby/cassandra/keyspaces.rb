#!/opt/ruby/1.9.3/bin/ruby
# -*- coding: utf-8 -*-
# keyspaces.rb: List keyspaces of a local Cassandra server
#
# Description:
# List the keyspaces of a local Cassandra server.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby keyspaces.rb
#
# Requirements:
# - Ruby 1.9.3 or later, as the shebang suggests
# - The cassandra gem
# - A Cassandra server on localhost
#

require 'rubygems'
require 'cassandra'
include Cassandra::Constants

client = Cassandra.new("Keyspace1", "127.0.0.1:9160")

p client.keyspaces
