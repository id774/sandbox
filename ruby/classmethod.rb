#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

# The singleton method form
class Hoge1
  def Hoge1.bar
    p 'hoge1'
  end
end

# It may also sit outside the class definition
class Hoge2
end

def Hoge2.bar
  p 'hoge2'
end

# Written this way, renaming the class leaves the method body untouched
class Hoge3
  def self.bar
    p 'hoge3'
  end
end

# The singleton class form, suited to defining several methods at once
class Hoge4
end

class << Hoge4
  def bar
    p 'hoge4'
  end
end

# Extending a class with a module turns the module's instance methods
# into class methods
module Foo
  def bar
    p 'hoge5'
  end
end

class Hoge5
  extend Foo
end

if __FILE__ == $0
  Hoge1.bar
  Hoge2.bar
  Hoge3.bar
  Hoge4.bar
  Hoge5.bar
end
