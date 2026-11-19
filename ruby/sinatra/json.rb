# coding:utf-8
# json.rb: JSON document served from Sinatra
#
# Description:
# Serve a JSON document from Sinatra with an explicit charset.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby json.rb
#
# Requirements:
# - Ruby
# - The sinatra gem
#

require 'sinatra'
require 'json'

set :port, 3000

get '/topics.json' do
  content_type :json, :charset => 'utf-8'
  data = { "ほげ" => 1, "ふが" => 2 }
  topics = JSON.generate(data)
end

