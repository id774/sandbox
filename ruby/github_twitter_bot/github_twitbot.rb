# github_twitbot.rb: Post GitHub webhook payloads to Twitter
#
# Description:
# Post GitHub webhook payloads to Twitter through Rubytter, reading its
# settings from github_twitbot.yaml.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby github_twitbot.rb
#
# Requirements:
# - Ruby
# - The rubytter gem
# - github_twitbot.yaml in the current directory
#

require 'rubytter'
require 'json'
require 'yaml'

cgi = CGI.new

abort 'error' unless cgi["payload"] 

json = JSON.parse(cgi["payload"])

conf = YAML.load_file("github_twitbot.yaml")

t = Rubytter.new

json["commits"].each do |c|
    t.update("#{c["name"]}: #{c["message"]}")
end
