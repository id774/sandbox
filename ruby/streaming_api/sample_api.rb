# sample_api.rb: Print messages from the Twitter sample stream
#
# Description:
# Print messages from the Twitter sample stream, authenticating with the user
# name and password given as arguments.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby sample_api.rb <user> <password>
#
# Requirements:
# - Ruby
# - The Twitter streaming API with basic authentication as it existed at the
#   time
#

require 'net/http'
require 'json'
require 'uri'

abort 'usage: sample_api.rb username password' unless ARGV.length >= 2

uri = URI.parse('http://stream.twitter.com/1/statuses/sample.json')

Net::HTTP.start(uri.host,80) do |h|
    q = Net::HTTP::Get.new(uri.request_uri)
    q.basic_auth(ARGV[0],ARGV[1])
    h.request(q) do |r|
        r.read_body do |b|
            j = JSON.parse(b) rescue next
            puts j["text"] if j["text"]
        end
    end
end
