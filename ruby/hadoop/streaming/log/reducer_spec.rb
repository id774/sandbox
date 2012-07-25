#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'rubygems'
require 'rspec'

class Reducer
  def self.run
    `cat data.txt | ruby mapper.rb | sort | ruby reducer.rb`
  end
end

describe Reducer do
  it 'Reduce 処理の結果が返る' do
    expect = "211.9.48.49\tUNKNOWN\t1\n218.213.26.164\tUNKNOWN\t1\n88.182.29.128\tmar44-5-88-182-29-128.fbx.proxad.net\t2\n88.182.8.57\tbac69-10-88-182-8-57.fbx.proxad.net\t1\n"
    Reducer.run.should == expect
  end
end
