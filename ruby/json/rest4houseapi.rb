# -*- coding: utf-8 -*-

require 'rest-client'

json = {"hoge" => "fuga"}
tag = "debug.forward"
response = RestClient.post('http://houseapi:kogaidan@157.7.155.117/post',
  {:tag => tag, :data => json},
  {:content_type => :json, :accept => :json})

