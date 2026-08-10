#!/usr/bin/ruby env
# Show how return behaves differently in a Proc and in a lambda.

def method_Proc
  obj = Proc.new { return 10 }
  res = obj.call
  res * 2
end

def method_lambda
  obj = lambda { return 10 }
  res = obj.call
  res * 2
end

p method_Proc   # => 10
p method_lambda # => 20

