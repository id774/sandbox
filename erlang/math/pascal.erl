%% pascal.erl: The first 10 rows of Pascal's triangle
%%
%% Description:
%% Print 10 rows of Pascal's triangle, each row summed from the previous one shifted both ways.
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
%%     escript pascal.erl
%%
%% Requirements:
%% - Erlang/OTP 20 or later (escript)
%% - No third-party package is required

-module(pascal).
-export([main/1]).

next(Row) ->
    lists:zipwith(fun(Left, Right) -> Left + Right end, [0 | Row], Row ++ [0]).

walk(_Row, 0) ->
    ok;
walk(Row, Remaining) ->
    io:format("~s~n", [string:join([integer_to_list(V) || V <- Row], " ")]),
    walk(next(Row), Remaining - 1).

main(_) ->
    walk([1], 10).
