require 'rubygems'
require 'id3lib'

tag = ID3Lib::Tag.new('this_book_is_made_of_rabbits_and_lemonade.mp3')

tag << {:id => :TPE1, :text => "_why", :textenc => 1}
tag << {:id => :TALB, :text => "THE SOUNDTRACK TO WHY'S (POIGNANT) GUIDE TO RUBY", :textenc => 1}
tag << {:id => :TIT2, :text => "This Book is Made (of Rabbits and Lemonade)", :textenc => 1}
tag << {:id => :TSOP, :text => "why", :textenc => 1} # SEGV not raised if delete this line

tag.update!
