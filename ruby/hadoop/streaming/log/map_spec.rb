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
    expect = "100.101.102.103\t1\n100.101.102.105\t1\n100.101.102.103\t1\n"
    Mapper.run.should == expect
  end
end
