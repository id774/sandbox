%% Print the start below 1000 with the longest Collatz sequence, tracked in a fold over the range.
%% Run: escript collatz.erl

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
