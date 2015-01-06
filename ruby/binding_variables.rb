#!/opt/ruby/2.2/bin/ruby

require 'pp'

class Hoge
  def hoge(msg)
    a = 1
    b = 2
    pp binding.local_variables
  end
end

Hoge.new.hoge("@@hoge@@")
