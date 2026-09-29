%% fibonacci.erl: The first 20 Fibonacci numbers
%%
%% Description:
%% Print the first 20 Fibonacci numbers, accumulated by a tail-recursive loop.
%%
%% Part of the basics cross-language exercise set: the input is fixed in the
%% source, and the output is the same as that of the same exercise in every
%% other language. The exercises are specified in README.md at the
%% repository root.
%%
%% Author: id774 (More info: https://id774.net)
%% Source Code: https://github.com/id774/sandbox
%% License: The GPL version 3, or LGPL version 3 (Dual License).
%% Contact: idnanashi@gmail.com
%%
%% Usage:
%%     escript fibonacci.erl
%%
%% Requirements:
%% - Erlang/OTP 20 or later (escript)
%% - No third-party package is required

-module(fibonacci).
-export([main/1]).

fibonacci(Count) ->
    fibonacci(Count, 0, 1, []).

fibonacci(0, _Current, _Next, Acc) ->
    lists:reverse(Acc);
fibonacci(Count, Current, Next, Acc) ->
    fibonacci(Count - 1, Next, Current + Next, [Current | Acc]).

main(_) ->
    Values = [integer_to_list(V) || V <- fibonacci(20)],
    io:format("~s~n", [string:join(Values, " ")]).
