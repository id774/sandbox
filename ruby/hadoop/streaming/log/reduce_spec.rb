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
    expect = "100.101.102.103\t2\n100.101.102.105\t1\n"
    Reducer.run.should == expect
  end
end
