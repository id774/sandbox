# hi.rb: Sinatra greeting with a root redirect
#
# Description:
# Serve a greeting from Sinatra and redirect the root to it.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby hi.rb
#
# Requirements:
# - Ruby
# - The sinatra gem
#

require 'sinatra'

set :port, 3000

get '/' do
  redirect "/hi"
end

get '/hi' do
  'Hello World'
end
