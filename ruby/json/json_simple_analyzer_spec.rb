#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

$:.unshift File.join(File.dirname(__FILE__))

require 'rubygems'
require 'rspec'
require 'json_simple_analyzer'

class Output
  attr_accessor :print
  def initialize; @print = []; end
  def write(msg); @print.push(msg); end
  def self.dump
    output = self.new
    $stdout = output
    yield
    $stdout = STDOUT
    return output.print
  end
end

describe Analyzer do
  context 'の start メソッドにおいて' do
    describe 'クラスに空の引数を与えると' do
      it 'json.txt の JSON が配列が返る' do
        analyzer = Analyzer.new([])
        result = Output.dump { analyzer.start }
        result.length.should be_eql 46
        result.class.should be_eql Array
        result[44].should be_eql "23\t状況\t1"
        result[45].should be_eql "\n"
      end
    end

    describe 'クラスにファイル名を引数として与えると' do
      it 'ファイル内容の JSON が配列が返る' do
        analyzer = Analyzer.new(['json2.txt'])
        result = Output.dump { analyzer.start }
        result.length.should be_eql 46
        result.class.should be_eql Array
        result[44].should be_eql "23\tふが\t1"
        result[45].should be_eql "\n"
      end
    end
  end
end
