#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

$:.unshift File.join(File.dirname(__FILE__))

require 'rubygems'
require 'rspec'
require 'json_simple_analyzer'

class Output
  attr_accessor :print, :dump

  def initialize
    @print = []
    @dump  = []
  end

  def write(msg); @print.push(msg); end

  def self.dump(separator = $/)
    output = self.new
    $stdout = output
    yield
    $stdout = STDOUT
    output.print.join.each_line(separator = separator) {|line| output.dump << line }
    return output.dump
  end
end

describe Analyzer do
  context 'の start メソッドにおいて' do
    describe 'クラスに空の引数を与えると' do
      it 'json.txt の JSON が配列が返る' do
        analyzer = Analyzer.new([])
        result = Output.dump { analyzer.start }
        expected = [
          "1\t実施\t6\n",
          "2\t藤原\t4\n",
          "3\t案件\t4\n",
          "4\t目的\t4\n",
          "5\t挨拶\t4\n",
          "6\t者\t2\n",
          "7\t数量\t2\n",
          "8\t増\t2\n",
          "9\t合わせ\t2\n",
          "10\t顧客\t2\n",
          "11\t責任\t2\n",
          "12\t今後\t2\n",
          "13\t依頼\t2\n",
          "14\t等\t2\n",
          "15\t状況\t2\n",
          "16\t着手\t2\n",
          "17\t実績\t2\n",
          "18\t活動\t2\n",
          "19\t期初\t2\n",
          "20\tその他\t2\n",
          "21\t該当\t2\n",
          "22\t注文\t2\n",
          "23\t担当\t1\n"
        ]
        result.length.should be_eql 23
        result.class.should be_eql Array
        result.should eq expected
      end
    end

    describe 'クラスにファイル名を引数として与えると' do
      it 'ファイル内容の JSON が配列が返る' do
        analyzer = Analyzer.new( ['json2.txt'] )
        result = Output.dump { analyzer.start }
        result.length.should be_eql 23
        expected = [
          "1\t実施\t6\n",
          "2\t藤原\t4\n",
          "3\t案件\t4\n",
          "4\t目的\t4\n",
          "5\t挨拶\t4\n",
          "6\t者\t2\n",
          "7\t数量\t2\n",
          "8\t増\t2\n",
          "9\t合わせ\t2\n",
          "10\t顧客\t2\n",
          "11\t責任\t2\n",
          "12\t今後\t2\n",
          "13\t依頼\t2\n",
          "14\t等\t2\n",
          "15\tふが\t2\n",
          "16\t着手\t2\n",
          "17\t実績\t2\n",
          "18\t活動\t2\n",
          "19\t期初\t2\n",
          "20\tその他\t2\n",
          "21\t該当\t2\n",
          "22\t注文\t2\n",
          "23\tほげ\t1\n"
        ]
        result.length.should be_eql 23
        result.class.should be_eql Array
        result.should eq expected
      end
    end
  end
end
