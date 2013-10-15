#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-

require 'screening'
require 'awesome_print'

data = Screening::Data.new
data.start do |element|
  element.title   = "title1"
  element.content = "content1"
end
data.start do |element|
  element.title   = "fake"
  element.content = "fake content"
end

puts "Initial (Class is Screening::Data)"
puts data.class
ap data

data.push({title: "title2", content: "content2"})
puts "Pushed"
ap data # => [{:title=>"title1", :content=>"content1"}, {:title=>"fake", :content=>"fake content"}, {:title=>"title2", :content=>"content2"}]

puts "if you want to classify data,"
ap data
puts "High"
data.classify(:high, :title, lambda{|e| e == "content2"})
ap data.high  # => [{:title=>"title2", :content=>"content2"}]

puts "if you want to omit data,"
ap data
puts "Omit"
data.omit(:title, lambda{|e| e == "fake"})
ap data # => [{:title=>"title1", :content=>"content1"}, {:title=>"title2", :content=>"content2"}]
puts "Garbage"
ap data.garbage   # => [{:title=>"fake", :content=>"fake content"}]

puts "if you want to change data,"
ap data
puts "Filter"
data.filter(:title, lambda do |e|
              e.gsub(/title/, "change") || e
            end)
ap data # => [{:title=>"change1", :content=>"content1"}, {:title=>"change2", :content=>"content2"}]

puts "if you want NOT to make attributes of data changed,"
ap data
puts "Bind"
data.bind([:title, :content])
begin
  data.push({test: "test"}) # => raise error
rescue RuntimeError
  puts "Runtime Error Raised"
end
