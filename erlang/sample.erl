%% sample.erl: Draft recursive Fibonacci function
%%
%% Description:
%% Sketch a recursive Fibonacci function; this draft does not compile.
%%
%% Author: id774 (More info: https://id774.net)
%% Source Code: https://github.com/id774/sandbox
%% License: The GPL version 3, or LGPL version 3 (Dual License).
%% Contact: idnanashi@gmail.com
%%
%% Requirements:
%% - Erlang/OTP, although the current source does not compile
%%

-module(fibonacci).
-export([f/1]).

f(E,F,X) ->(
	Y = E+F
	if X <= 0 -> io:put_chars(Y+"\n");f(F,Y,X+1);
).
