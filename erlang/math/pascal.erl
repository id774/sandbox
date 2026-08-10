%% Print 10 rows of Pascal's triangle, each row summed from the previous one shifted both ways.
%% Run: escript pascal.erl

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
