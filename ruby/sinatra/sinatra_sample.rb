# sinatra_sample.rb: Sinatra greeting
#
# Description:
# Serve a greeting from Sinatra.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby sinatra_sample.rb
#
# Requirements:
# - Ruby
# - The sinatra gem
#

require 'sinatra'
require 'rubygems'

set :port, 8333

get '/' do
  'Hello sinatra'
end
