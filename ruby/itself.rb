
array = %i(a f b f c c b d b)
p array.group_by(&:itself).map { |k,v| [k, v.count] }

nums = [1,2,3,4,5,1,2,2,3]
p nums.itself { |s| s.inject(:+) / s.size.to_f  } # => 2.5555555555555554
p nums.group_by(&:itself) # => {1=>[1, 1], 2=>[2, 2, 2], 3=>[3, 3], 4=>[4], 5=>[5]}

