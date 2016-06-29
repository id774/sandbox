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

  doc.xpath("/html/head/meta").each do |node|
    unless node.attribute("name").nil?
      @keywords = node.attribute("content").value if node.attribute("name").value.include?("keywords")
    end
  end

  h2 = @keywords.split(",")[0]
  h1 = @keywords.split(",")[1]

  doc.xpath('//span[@class="icoQ"]').each do |node|
    puts "#{i},#{h1},#{h2},質問,\"#{node.text.strip}\""
  end

  doc.xpath('//div[@class="faq_ansCont_txt clearfix"]').each do |node|
    puts "#{i},#{h1},#{h2},回答,\"#{node.text.strip}\""
  end
end

(0..1200).each do |i|
  url = "https://faq.mizuho-sc.com/faq/show/#{i}"
  parse(url, i)
end