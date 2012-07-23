#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'rubygems'
require 'rspec'

class Mapper
  def self.run
    `cat data.txt | ruby map.rb`
  end
end

describe Mapper do
  it 'Map 処理の結果が返る' do
    expect = "aaa\t1\nbbb\t1\nccc\t1\nddd\t1\neee\t1\nfff\t1\nggg\t1\nhhh\t1\naaa\t1\nbbb\t1\nccc\t1\nddd\t1\n"
    Mapper.run.should == expect
  end
end
