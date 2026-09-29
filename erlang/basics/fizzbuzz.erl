%% fizzbuzz.erl: FizzBuzz for 1 through 100
%%
%% Description:
%% Print FizzBuzz for 1 through 100, choosing the label by matching the remainders.
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
%%     escript fizzbuzz.erl
%%
%% Requirements:
%% - Erlang/OTP 20 or later (escript)
%% - No third-party package is required

-module(fizzbuzz).
-export([main/1]).

label(N) ->
    case {N rem 3, N rem 5} of
        {0, 0} -> "FizzBuzz";
        {0, _} -> "Fizz";
        {_, 0} -> "Buzz";
        _ -> integer_to_list(N)
    end.

main(_) ->
    lists:foreach(fun(N) -> io:format("~s~n", [label(N)]) end, lists:seq(1, 100)).
