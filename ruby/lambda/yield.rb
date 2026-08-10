# -*- coding: utf-8 -*-
# Yield values to a block from inside a method.

def return_yield
  puts("Before the yield.")
  yield (20)
  yield (10)
  puts("After the yield.")
end

return_yield {|x|
  puts "#{x}"
}

