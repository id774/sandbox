# -*- coding: utf-8 -*-

def my_method
  yield
end

top_level_var = 1

my_method {
  top_level_var += 1
  local_to_block = 3
}

p top_level_var
p local_to_block

