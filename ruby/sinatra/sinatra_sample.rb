# Serve a greeting from Sinatra.

require 'sinatra'
require 'rubygems'

set :port, 8333

get '/' do
  'Hello sinatra'
end
