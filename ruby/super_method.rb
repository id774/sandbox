#!/opt/ruby/2.2/bin/ruby

class Parent
  def hoge
    "super hoge"
  end
end

class Child < Parent
  def hoge
    "child hoge"
  end
end

child = Child.new
p child.hoge
p child.public_method(:hoge).super_method
p child.public_method(:hoge).super_method.call
