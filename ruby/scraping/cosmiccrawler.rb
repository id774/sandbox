require 'cosmicrawler'

Cosmicrawler.http_crawl(%w(http://b.hatena.ne.jp/hotentry/it http://b.hatena.ne.jp/hotentry/life)) {|request|
  get = request.get
  puts get.response if get.response_header.status == 200
}
