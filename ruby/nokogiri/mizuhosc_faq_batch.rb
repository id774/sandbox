require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'nkf'

def parse(url, i)
  charset = nil
  html = open(url) do |f|
    charset = f.charset
    f.read
  end

  doc = Nokogiri::HTML.parse(html, nil, charset)

  doc.xpath('//span[@class="icoQ"]').each do |node|
    puts "#{i},質問,\"#{node.text.strip}\""
  end

  doc.xpath('//div[@class="faq_ansCont_txt clearfix"]').each do |node|
    puts "#{i},回答,\"#{node.text.strip}\""
  end
end

(2000..9999).each do |i|
  url = "https://faq.mizuho-sc.com/faq/show/#{i}"
  parse(url, i)
end
