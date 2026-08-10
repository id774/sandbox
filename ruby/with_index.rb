# Iterate with each.with_index starting the index at 1.

%w(杏子 さやか マミ).each.with_index(1) do |element, i|
  puts "#{i} #{element}"
end
