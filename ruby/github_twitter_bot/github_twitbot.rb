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
