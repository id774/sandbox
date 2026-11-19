# -*- coding: utf-8 -*-
# rest4houseapi.rb: Post a JSON payload with RestClient
#
# Description:
# Post a JSON payload with RestClient to a placeholder example.com endpoint
# whose user name and password are placeholders.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby rest4houseapi.rb
#
# Requirements:
# - Ruby
# - The rest-client gem
# - Network access to a real endpoint in place of the placeholder
#

require 'rest-client'

json = {"hoge" => "fuga"}
tag = "debug.forward"
response = RestClient.post('http://YOUR_USER:YOUR_PASSWORD@example.com/post',
  {:tag => tag, :data => json},
  {:content_type => :json, :accept => :json})

