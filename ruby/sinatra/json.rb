# coding:utf-8
# Serve a JSON document from Sinatra with an explicit charset.

require 'sinatra'
require 'json'

set :port, 3000

get '/topics.json' do
  content_type :json, :charset => 'utf-8'
  data = { "ほげ" => 1, "ふが" => 2 }
  topics = JSON.generate(data)
end

