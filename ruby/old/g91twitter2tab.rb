require 'rubygems';require 'mechanize'
(puts "usage: g91twitter2tab.rb (csv|tween)";exit) if !ARGV[0]
agent = WWW::Mechanize.new;agent.get('http://generation1991.g.hatena.ne.jp/keyword/%E3%83%A1%E3%83%B3%E3%83%90%E3%83%BC%E4%B8%80%E8%A6%A7')
twits = [];agent.page.search(".section/table/tr/td[3]/a").each{|x|twits << x.inner_text}
if ARGV[0] =~ /csv/
    twits.each{|x| print x.sub(/^@/,"")+","}
else
    twits.each do |x|
    text = <<EOF
      <FiltersClass>
        <NameFilter>#{x.sub(/^@/,"")}</NameFilter>
        <BodyFilterArray />
        <SearchBoth>true</SearchBoth>
        <MoveFrom>false</MoveFrom>
        <SetMark>false</SetMark>
        <SearchUrl>false</SearchUrl>
        <UseRegex>false</UseRegex>
      </FiltersClass>
EOF
    puts text
    end
end
puts ""
