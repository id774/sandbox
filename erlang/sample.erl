-module(fibonacci).
-export([f/1]).

f(E,F,X) ->(
	Y = E+F
	if X <= 0 -> io:put_chars(Y+"\n");f(F,Y,X+1);
).
