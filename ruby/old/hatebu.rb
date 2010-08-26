require 'open-uri'
#エラーではじく
(puts "usage: hatebu.rb url";exit) if !ARGV[0]
#初期取得
bcount = open('http://b.hatena.ne.jp/entry/json/'+ARGV[0]){|f|f.read.sub(/^\({"count":/,"").sub(/","eid.+/,"").sub(/[^0-9]*/,"").to_i}
puts "bcount(init) = "+bcount.to_s
puts "----"
loop do
    bcount2 = open('http://b.hatena.ne.jp/entry/json/'+ARGV[0]){|f|f.read.sub(/^\({"count":/,"").sub(/","eid.+/,"").sub(/[^0-9]*/,"").to_i}
    puts "bcount = "+bcount.to_s
    puts "bcount2 = "+bcount2.to_s
    if bcount != bcount2
        system("say Detteiu")
        bcount = bcount2
        puts "say Detteiu"
    end
    puts "sleep 60"
    sleep 60
    puts "----"
end
