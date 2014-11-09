require 'sinatra'

set :port, 3000

get '/' do
  redirect "/hi"
end

get '/hi' do
  'Hello World'
end
