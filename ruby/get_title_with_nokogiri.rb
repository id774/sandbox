# get_title_with_nokogiri.rb: Extract a page title with Nokogiri
#
# Description:
# Fetch a page and extract its title with Nokogiri.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby get_title_with_nokogiri.rb
#
# Requirements:
# - Ruby before 3.0, whose Kernel#open still opens URLs through open-uri
# - The nokogiri gem
# - Network access to the page in the source
#

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'nkf'

def get_title(url)
  url.gsub!(Regexp.new("[^#{URI::PATTERN::ALNUM}\/\:\?\=&~,\.\(\)#]")) {|match| ERB::Util.url_encode(match)}
  read_data = NKF.nkf("--utf8", open(url).read)
  Nokogiri::HTML.parse(read_data, nil, 'utf8').xpath('//title').text
end

p get_title('http://blog.id774.net/post/2014/10/01/531/')
