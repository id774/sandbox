# -*- coding: utf-8 -*-

def return_yield
  puts("Before the yield.")
  yield (20)
  yield (10)
  puts("After the yield.")
end

return_yield {|x|
  puts "#{x}"
}

