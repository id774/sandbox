#!/opt/ruby/2.2/bin/ruby
# List the local variables visible through binding inside a method.

require 'pp'

class Hoge
  def hoge(msg)
    a = 1
    b = 2
    pp binding.local_variables
  end
end

Hoge.new.hoge("@@hoge@@")
