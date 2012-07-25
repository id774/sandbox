#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'rubygems'
require 'rspec'

class Mapper
  def self.run
    `cat data.txt | ruby mapper.rb`
  end
end

describe Mapper do
  it 'Map 処理の結果が返る' do
    expect = "88.182.8.57\t1\n88.182.29.128\t1\n218.213.26.164\t1\n211.9.48.49\t1\n88.182.29.128\t1\n"
    Mapper.run.should == expect
  end
end
