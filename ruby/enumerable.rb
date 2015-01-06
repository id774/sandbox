#!/opt/ruby/2.2/bin/ruby

print *[1, 1, 2, 3, 3, 4, 5].slice_before(&:even?), "\n"
print *[1, 1, 2, 3, 3, 4, 5].slice_after(&:even?), "\n"

print [1, 1, 2, 3, 3, 4, 5].slice_when { |a, b| a.odd? && b.even? }.to_a

print [*'1'..'11'].min(3), "\n"
print [*'1'..'11'].min_by(3) { |e|e.to_i }, "\n"
print [*'1'..'11'].max(3), "\n"
print [*'1'..'11'].max_by(3) { |e|e.to_i }, "\n"

