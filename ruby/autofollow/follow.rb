# follow.rb - (Twitter) Auto follow other user's following users
# Author: Sora harakami <sora134[at]gmail.com>
# Licence: MIT licence
#  The MIT Licence {{{
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in
#  all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#  THE SOFTWARE.
#  }}}
#
# usage:
#   follow.rb <username> [username] [password]
# setting:
#   $HOME/.twitter
#     username: <USERNAME HERE>
#     password: <PASSWORD HERE>

require "rubytter"
require "yaml"

(puts "usage: follow.rb <username> [username] [password]";exit) unless ARGV[0]

ta = ( ARGV[1] && ARGV[2] ) ? {"username" => ARGV[1], "password" => ARGV[2]} : YAML.load_file(ENV['HOME']+'/.twitter')
t = Rubytter.new(ta["username"],ta["password"]) 

f = t.followers_ids(ARGV[0])
ff = t.friends_ids(ta["username"])
$i = 0

f.each do |u|
    begin
        unless ff.include?(u)
            t.follow(u) 
            puts "follow: "+u.to_s
            $i += 1
        end
    rescue Rubytter::APIError => e
        if /You are unable to follow more people at this time/ =~ e.to_s || /You have been blocked from following this account at the request of the user./ =~ e.to_s
            puts "ERROR: Could not follow user - You are unable to follow more people at this time."
            puts "------"
            puts "Total followed: "+$i.to_s
            puts "Sleep 600 sec"
            sleep 600
        end
        puts "error : " + e.inspect
    rescue => e
        puts "Ruby error : " + e.inspect
    end
end

puts "------"
puts "Total followed: "+$i.to_s

