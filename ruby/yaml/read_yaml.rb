# -*- coding: utf-8 -*-

require 'yaml'

config = YAML.load_file('config.yml.sample')

p config["auth"]["consumer_key"]
p config["auth"]["consumer_secret"]
p config["auth"]["oauth_token"]
p config["auth"]["oauth_token_secret"]

p config["env"]["source_screen_names"]
p config["env"]["screen_name"]
p config["env"]["lince_last_updated"] * 60
p config["env"]["interval"] * 60
p config["env"]["await"] * 60

