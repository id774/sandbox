%% fibonacci.erl: Recursive Fibonacci sequence in a mismatched module
%%
%% Description:
%% Print a Fibonacci sequence recursively; the module name does not match the
%% file name.
%%
%% Author: id774 (More info: https://id774.net)
%% Source Code: https://github.com/id774/sandbox
%% License: The GPL version 3, or LGPL version 3 (Dual License).
%% Contact: idnanashi@gmail.com
%%
%% Requirements:
%% - Erlang/OTP, although erlc rejects the file because its module is named
%%   fib
%%

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