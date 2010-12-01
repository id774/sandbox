#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

# 特異メソッド方式。
class Hoge1
  def Hoge1.bar
    p 'hoge1'
  end
end

# クラス定義の外でも良い
class Hoge2
end

def Hoge2.bar
  p 'hoge2'
end

# 以下のようにすればクラス名が変わってもメソッド部の変更が不要
class Hoge3
  def self.bar
    p 'hoge3'
  end
end

# 特異クラス方式。複数のメソッドを一度に定義するとき向き
class Hoge4
end

class << Hoge4
  def bar
    p 'hoge4'
  end
end

# モジュールをクラスに extend すれば、モジュールのインスタンス
# メソッドがクラスメソッドになる
module Foo
  def bar
    p 'hoge5'
  end
end

class Hoge5
  extend Foo
end

Hoge1.bar
Hoge2.bar
Hoge3.bar
Hoge4.bar
Hoge5.bar
