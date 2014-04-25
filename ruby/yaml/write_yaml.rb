# -*- coding: utf-8 -*-

require 'yaml'

config = YAML.load_file('config.yml.sample')

config["auth"]["consumer_key"] = "a"
config["auth"]["consumer_secret"] = "b"
config["auth"]["oauth_token"] = "c"
config["auth"]["oauth_token_secret"] = "d"

open("config.yml.new", "w") do |f|
  YAML.dump(config, f)
end

