#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-

require 'screening'

data = Screening::Data.new
data.start do |element|
  element.title   = "title1"
  element.content = "content1"
end
data.start do |element|
  element.title   = "fake"
  element.content = "fake content"
end

data.push({title: "title2", content: "content2"})
p data # => [{:title=>"title1", :content=>"content1"}, {:title=>"fake", :content=>"fake content"}, {:title=>"title2", :content=>"content2"}]

puts "if you want to classify data,"

data.classify(:high, :title, lambda{|e| e == "content2"})
p data.high  # => [{:title=>"title2", :content=>"content2"}]

puts "if you want to omit data,"

data.omit(:title, lambda{|e| e == "fake"})
p data # => [{:title=>"title1", :content=>"content1"}, {:title=>"title2", :content=>"content2"}]
p data.garbage   # => [{:title=>"fake", :content=>"fake content"}]

puts "if you want to change data,"

data.filter(:title, lambda do |e|
              e.gsub(/title/, "change") || e
            end)
p data # => [{:title=>"change1", :content=>"content1"}, {:title=>"change2", :content=>"content2"}]

puts "if you want NOT to make attributes of data changed,"

data.bind([:title, :content])
begin
  data.push({test: "test"}) # => raise error
rescue RuntimeError
  puts "Runtime Error Raised"
end
