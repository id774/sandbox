require 'sinatra'

set :port, 3000

get '/hi' do
  'Hello World'
end
