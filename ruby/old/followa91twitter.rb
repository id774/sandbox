require 'rubygems';require 'mechanize';require 'rubytter'
agent = WWW::Mechanize.new;agent.get('http://generation1991.g.hatena.ne.jp/keyword/%E3%83%A1%E3%83%B3%E3%83%90%E3%83%BC%E4%B8%80%E8%A6%A7')
twits = [];agent.page.search(".section/table/tr/td[3]/a").each{|x|twits << x.inner_text}
t = Rubytter.new($ARGV[0],$ARGV[1])
twits.each do |x|
    puts "follow #{x}"
    t.update("follow #{x}")
end
