# -*- coding: utf-8 -*-

require 'restclient'

json = {"hoge" => "fuga"}
tag = "debug.forward"
response = RestClient.post('http://133.242.144.202/solve',
  {:tag => tag, :data => json},
  {:content_type => :json, :accept => :json})

