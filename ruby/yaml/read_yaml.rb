# -*- coding: utf-8 -*-
# read_yaml.rb: Read nested settings from a YAML file
#
# Description:
# Read nested settings out of config.yml.sample.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby read_yaml.rb
#
# Requirements:
# - Ruby
# - config.yml.sample in the current directory
#

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

