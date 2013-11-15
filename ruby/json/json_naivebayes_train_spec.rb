#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

$:.unshift File.join(File.dirname(__FILE__))

require 'rubygems'
require 'rspec'
require 'stdout'
require 'json_naivebayes_train'

describe Analyzer do
  context 'の start メソッドにおいて' do
    describe 'クラスにファイル名を引数として与えると' do
      it 'クラスとその素性が出力される' do
        analyzer = Analyzer.new( ['train.txt'] )
        result = Stdout::Output.capture { analyzer.start }
        expected = [
          "1111\t価格\t{\"競合\":1,\"企業\":1,\"入札\":1,\"選定\":1,\"落選\":1}\n",
          "1111\t価格\t{\"競合企業との入札にて落選\":1,\"入札にて落選\":1,\"選定落選\":1}\n",
          "2222\t要員不在\t{\"要員\":1,\"不在\":1,\"辞退\":1}\n",
          "2222\t要員不在\t{\"要員不在につき辞退\":1,\"辞退\":1}\n"
        ]
        result.length.should eql 4
        result.class.should eql Array
        result.should eq expected
      end
    end
  end
end
