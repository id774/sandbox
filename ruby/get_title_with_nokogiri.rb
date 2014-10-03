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
