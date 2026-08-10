# -*- coding: utf-8 -*-
# Show that a block closes over the variables where it was written.

def my_method
  x = "Goodbye"
  yield("cruel")
end

x = "Hello"
puts my_method {|y| "#{x}, #{y} world" }

