#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

$:.unshift File.join(File.dirname(__FILE__))

require 'rubygems'
require 'rspec'
require 'stdout'
require 'json_context_analyzer'

describe Analyzer do
  context 'の start メソッドにおいて' do
    describe 'クラスにファイル名を引数として与えると' do
      subject {
        analyzer = Analyzer.new( ['context.txt'] )
        Stdout::Output.capture { analyzer.start }
      }

      let(:expected) {
        [
          "1111,あああ\t失注,価格\t{\"引合コード\":\"1111\",\"案件名\":\"あああ\",\"顧客企業\":\"ほげほげ株式会社\",\"自社担当者ユーザID\":\"123456\",\"担当組織\":\"営業部\",\"案件概要\":\"あああいいいううう\",\"受注予定額\":\"150\",\"受注額\":null,\"受失注結果\":\"失注\",\"受失注確定日\":\"2013/11/13\",\"受失注要因\":\"価格\",\"受失注コメント\":\"競合企業との入札にて選定落選\",\"words\":[\"競合\",\"企業\",\"入札\",\"選定\",\"落選\"],\"deps\":[\"競合企業との入札にて落選\",\"入札にて落選\",\"選定落選\"]}\n",
          "2222,いいい\t失注,価格\t{\"引合コード\":\"2222\",\"案件名\":\"いいい\",\"顧客企業\":\"ふがふが株式会社\",\"自社担当者ユーザID\":\"234567\",\"担当組織\":\"営業部\",\"案件概要\":\"ううう\\nえええ\\nおおお\",\"受注予定額\":\"210\",\"受注額\":null,\"受失注結果\":\"失注\",\"受失注確定日\":null,\"受失注要因\":\"価格\",\"受失注コメント\":\"金額\",\"words\":[\"金額\"],\"deps\":[\"金額\"]}\n"
        ]
      }

      it '語彙群と係り受け群が追加された JSON が出力される' do
        expect(subject).to eq expected
      end
    end
  end
end
