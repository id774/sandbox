# -*- coding: utf-8 -*-

require 'yaml'

config = YAML.load_file('config.yml.sample')

auth = config["auth"]
p auth["consumer_key"]
p auth["consumer_secret"]
p config["auth"]["oauth_token"]
p config["auth"]["oauth_token_secret"]

env = config["env"]
p config["env"]["source_screen_names"]
p config["env"]["screen_name"]
p env["since_last_updated"] * 60
p env["interval"] * 60
p env["await"] * 60

