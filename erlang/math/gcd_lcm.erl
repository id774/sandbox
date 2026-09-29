%% gcd_lcm.erl: GCD and LCM of fixed pairs by Euclid's algorithm
%%
%% Description:
%% Print the divisor and multiple of fixed pairs, with Euclid's algorithm written as two clauses.
%%
%% Part of the math cross-language exercise set: it reads no arguments or
%% standard input, keeps its data fixed in the source, uses integer
%% arithmetic only, and its output is the same as that of the same exercise
%% in every other language. The exercises are specified in README.md at the
%% repository root.
%%
%% Author: id774 (More info: https://id774.net)
%% Source Code: https://github.com/id774/sandbox
%% License: The GPL version 3, or LGPL version 3 (Dual License).
%% Contact: idnanashi@gmail.com
%%
%% Usage:
%%     escript gcd_lcm.erl
%%
%% Requirements:
%% - Erlang/OTP 20 or later (escript)
%% - No third-party package is required

-module(gcd_lcm).
-export([main/1]).

euclid(First, 0) ->
    First;
euclid(First, Second) ->
    euclid(Second, First rem Second).

main(_) ->
    Pairs = [{1071, 462}, {270, 192}, {17, 5}, {120, 36}],
    lists:foreach(
        fun({First, Second}) ->
            Divisor = euclid(First, Second),
            io:format("~w ~w ~w ~w~n", [First, Second, Divisor, First div Divisor * Second])
        end,
        Pairs
    ).
