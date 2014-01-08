require 'anemone'

Anemone.crawl("http://www.id774.net") do |anemone|
  anemone.on_every_page do |page|
    title = page.doc.xpath("//head/title/text()").first.to_s if page.doc
    puts title
  end
end
