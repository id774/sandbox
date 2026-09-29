%% quicksort.erl: Quicksort of a fixed integer sequence
%%
%% Description:
%% Sort a fixed list with a quicksort over the head and tail of the list.
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
%%     escript quicksort.erl
%%
%% Requirements:
%% - Erlang/OTP 20 or later (escript)
%% - No third-party package is required

-module(quicksort).
-export([main/1]).

sort([]) ->
    [];
sort([Pivot | Rest]) ->
    sort([X || X <- Rest, X =< Pivot]) ++ [Pivot] ++ sort([X || X <- Rest, X > Pivot]).

main(_) ->
    Values = [integer_to_list(V) || V <- sort([5, 3, 8, 4, 2, 7, 1, 10, 9, 6])],
    io:format("~s~n", [string:join(Values, " ")]).
