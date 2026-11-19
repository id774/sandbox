# -*- coding: utf-8 -*-
# write_yaml.rb: Update a YAML file and write it back
#
# Description:
# Update the settings read from config.yml.sample and write them to
# config.yml.new.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby write_yaml.rb
#
# Requirements:
# - Ruby
# - config.yml.sample in the current directory
#

require 'yaml'

config = YAML.load_file('config.yml.sample')

config["auth"]["consumer_key"] = "a"
config["auth"]["consumer_secret"] = "b"
config["auth"]["oauth_token"] = "c"
config["auth"]["oauth_token_secret"] = "d"

open("config.yml.new", "w") do |f|
  YAML.dump(config, f)
end

