#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'rubygems'
require 'rspec'

class Reducer
  def self.run
    `cat data.txt | ruby map.rb | sort | ruby reduce.rb`
  end
end

describe Reducer do
  it 'Reduce 処理の結果が返る' do
    expect = "aaa\t2\nbbb\t2\nccc\t2\nddd\t2\neee\t1\nfff\t1\nggg\t1\nhhh\t1\n"
    Reducer.run.should == expect
  end
end
