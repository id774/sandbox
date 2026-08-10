# -*- coding: utf-8 -*-
# Post a JSON payload to an API with RestClient.

require 'rest-client'

json = {"hoge" => "fuga"}
tag = "debug.forward"
response = RestClient.post('http://houseapi:kogaidan@157.7.155.117/post',
  {:tag => tag, :data => json},
  {:content_type => :json, :accept => :json})

