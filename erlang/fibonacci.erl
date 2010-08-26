-module(fib).
-export([f/3]).

f(E,F,X) -> 
	if X > -1 -> io:put_chars(integer_to_list(E + F)),io:put_chars(",");
	   X /= 100 -> f(F,E+F,X+1)
	 end.

f2(E,F,X) -> 
if X > -1 -> io:put_chars(integer_to_list(E + F)),
	 io:put_chars("\n"),
	 if 	X /= 10 -> f2(F,E+F,X+1);
				true -> ok
	 end;
	 true -> ok
end.