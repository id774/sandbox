# -*- coding: utf-8 -*-

require 'rest-client'

json = {"hoge" => "fuga"}
tag = "debug.forward"
response = RestClient.post('http://username:password@133.242.144.202/post',
  {:tag => tag, :data => json},
  {:content_type => :json, :accept => :json})

