#!/opt/ruby/2.2/bin/ruby
# Curry a three argument method and apply the arguments one at a time.

def trapezoid(upper_base, lower_base, hight)
  (upper_base + lower_base) * hight / 2
end

trapezoid_10_20 = method(:trapezoid).curry(3).(10).(20)
p trapezoid_10_20.(2)
p trapezoid_10_20.(4)
