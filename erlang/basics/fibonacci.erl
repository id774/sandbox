%% Print the first 20 Fibonacci numbers, accumulated by a tail-recursive loop.
%% Run: escript fibonacci.erl

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
