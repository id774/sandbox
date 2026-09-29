%% collatz.erl: Longest Collatz sequence for a start below 1000
%%
%% Description:
%% Print the start below 1000 with the longest Collatz sequence, tracked in a fold over the range.
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
%%     escript collatz.erl
%%
%% Requirements:
%% - Erlang/OTP 20 or later (escript)
%% - No third-party package is required

-module(collatz).
-export([main/1]).

chain_length(1) ->
    1;
chain_length(N) when N rem 2 =:= 0 ->
    1 + chain_length(N div 2);
chain_length(N) ->
    1 + chain_length(N * 3 + 1).

main(_) ->
    {Longest, Best} = lists:foldl(
        fun(Start, {_BestStart, BestLength} = Acc) ->
            case chain_length(Start) of
                Length when Length > BestLength -> {Start, Length};
                _ -> Acc
            end
        end,
        {1, 1},
        lists:seq(1, 999)
    ),
    io:format("~w ~w~n", [Longest, Best]).
