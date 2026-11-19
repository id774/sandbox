#!/usr/bin/env ruby
# rest-graph_example.rb: Query the Facebook Graph API with rest-graph
#
# Description:
# Query the Facebook graph API with rest-graph.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby rest-graph_example.rb
#
# Requirements:
# - Ruby
# - The rest-graph gem
# - Network access to the Facebook Graph API
#

require 'rubygems'
require 'rest-graph'

rg = RestGraph.new(:access_token => 'xxx')

feed = rg.get('search', :q => 'test')

like = rg.get('me/likes')

like.values.first each { |f|
  puts f['name']
}
