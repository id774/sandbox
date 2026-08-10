%% Sort a fixed list with a quicksort over the head and tail of the list.
%% Run: escript quicksort.erl

-module(quicksort).
-export([main/1]).

sort([]) ->
    [];
sort([Pivot | Rest]) ->
    sort([X || X <- Rest, X =< Pivot]) ++ [Pivot] ++ sort([X || X <- Rest, X > Pivot]).

main(_) ->
    Values = [integer_to_list(V) || V <- sort([5, 3, 8, 4, 2, 7, 1, 10, 9, 6])],
    io:format("~s~n", [string:join(Values, " ")]).
