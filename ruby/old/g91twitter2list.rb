require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'rubytter'

(puts "usage: g91twitter2tab.rb TWITTER_USER TWITTER_PASSWORD [LIST_NAME=g91]";exit) if !ARGV[0] || !ARGV[1]

list_name = ARGV[2] ? ARGV[2] : "g91"

t = Rubytter.new(ARGV[0],ARGV[1])
members = Hpricot(open('http://generation1991.g.hatena.ne.jp/keyword/%E3%83%A1%E3%83%B3%E3%83%90%E3%83%BC%E4%B8%80%E8%A6%A7'))

twits = []
members.search(".section/table/tr/td[3]/a").each do |x|
    twits << x.inner_text
end

begin
    list_id = t.lists(ARGV[0]).lists{|l| l.slug }.index(list_name)
    unless list_id
        list = t.create_list(list_name)
    else
        list = t.lists(ARGV[0]).lists[list_id]
    end
rescue
end

puts "error" if list.nil?

list_members = t.list_members(ARGV[0],list.slug).map{|m| m.id }

if ARGV[0] =~ /csv/
    twits.each{|x| print x.sub(/^@/,"")+","}
else
    twits.each do |x|
        twitter_id = x.sub(/^@/,"")
        begin
            user_id = t.user(twitter_id).id
            if list_members.index(user_id).nil?
                puts "add: #{twitter_id}"
                t.add_member_to_list(list.slug,user_id)
                list_members << user_id
            else
                puts "skip: #{twitter_id}"
            end
        rescue => e
            p e
        end
    end
end
puts ""
puts "complete."
