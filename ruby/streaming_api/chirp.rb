# chirp.rb: Print messages from the Twitter Chirp user stream
#
# Description:
# Read the Twitter Chirp user stream at chirpstream.twitter.com and print each
# message, authenticating with the user name and password given as arguments.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby chirp.rb <user> <password>
#
# Requirements:
# - Ruby
# - The Twitter Chirp stream with basic authentication as it existed at the
#   time
#

require 'net/http'
require 'json'
require 'uri'

abort 'usage: chirp.rb username password' unless ARGV.length >= 2

uri = URI.parse('http://chirpstream.twitter.com/2b/user.json')

Net::HTTP.start(uri.host,80) do |h|
    q = Net::HTTP::Get.new(uri.request_uri)
    q.basic_auth(ARGV[0],ARGV[1])
    h.request(q) do |r|
        r.read_body do |b|
            j = JSON.parse(b) rescue next
            if j["event"]
              puts "#{j["event"]} / #{j["user"]["screen_name"]} -> #{j["target"]["user"]["screen_name"]} #{j["target"]["text"] || ""}" rescue p j
            else
              puts "Tweet / #{j["user"]["screen_name"]}: #{j["text"]}" rescue p j
            end
        end
    end
end
