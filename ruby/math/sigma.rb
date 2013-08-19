#!/opt/ruby/current/bin/ruby

n = 10
r1 = Range.new(1,n,false)

p r1.inject(0) {|result, item| result + item**2}
