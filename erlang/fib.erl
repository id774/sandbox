-module(fib).
-export([f/1,f/4,f2/1,f2/4,f3/1,f3/4]).
f(N) -> io:put_chars("1\n1\n"),f(1,1,1,N).
f(E,F,X,N) -> 
if X > -1 -> io:put_chars(integer_to_list(E + F)),
	 io:put_chars("\n"),
	 if 	X /= N -> f(F,E+F,X+1,N);
				true -> ok
	 end;
	 true -> ok
end.
f2(N) -> io:put_chars("1\n2\n"),f2(1,1,1,N).
f2(E,F,X,N) -> 
if X == N -> io:put_chars(integer_to_list(E+F));
   X > -1 -> io:put_chars(integer_to_list(X)),
	 io:put_chars("\n"),
	 if 	X /= N -> f2(F,E+F,X+1,N);
				true -> ok
	 end;
	 true -> ok
end.
f3(N) -> io:put_chars("0\n0\n"),f3(1,1,1,N).
f3(E,F,X,N) -> 
if X > -1 -> io:put_chars(float_to_list(math:log(E+F)/math:log(10))),
	 io:put_chars("\n"),
	 if 	X /= N -> f3(F,E+F,X+1,N);
				true -> ok
	 end;
	 true -> ok
end.
