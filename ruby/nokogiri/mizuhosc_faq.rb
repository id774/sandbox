require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'nkf'

url = "https://faq.mizuho-sc.com/faq/show/1055"
charset = nil

html = open(url) do |f|
  charset = f.charset
  f.read
end

doc = Nokogiri::HTML.parse(html, nil, charset)

doc.xpath('//span[@class="icoQ"]').each do |node|
  puts "質問,\"#{node.text.strip}\""
end

doc.xpath('//div[@class="faq_ansCont_txt clearfix"]').each do |node|
  puts "回答,\"#{node.text.strip}\""
end
