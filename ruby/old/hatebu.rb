# hatebu.rb: Report changes in a Hatena Bookmark count
#
# Description:
# Poll the Hatena Bookmark count for the URL given as an argument and report
# when it changes.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby hatebu.rb <URL>
#
# Requirements:
# - Ruby before 3.0, whose Kernel#open still opens URLs through open-uri
# - Network access to b.hatena.ne.jp
#

require 'open-uri'
# Reject on error
(puts "usage: hatebu.rb url";exit) if !ARGV[0]
# Initial fetch
bcount = open('http://b.hatena.ne.jp/entry/json/'+ARGV[0]){|f|f.read.sub(/^\({"count":/,"").sub(/","eid.+/,"").sub(/[^0-9]*/,"").to_i}
puts "bcount(init) = "+bcount.to_s
puts "----"
loop do
    bcount2 = open('http://b.hatena.ne.jp/entry/json/'+ARGV[0]){|f|f.read.sub(/^\({"count":/,"").sub(/","eid.+/,"").sub(/[^0-9]*/,"").to_i}
    puts "bcount = "+bcount.to_s
    puts "bcount2 = "+bcount2.to_s
    if bcount != bcount2
        system("say Detteiu")
        bcount = bcount2
        puts "say Detteiu"
    end
    puts "sleep 60"
    sleep 60
    puts "----"
end
