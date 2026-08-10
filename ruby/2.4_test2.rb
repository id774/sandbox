# Show that Ruby 2.4 unifies Fixnum and Bignum into Integer.

p 1.class # Integer
p -1.class # Integer
p 10000000000000000000000000000.class # Integer
p -10000000000000000000000000000.class # Integer
