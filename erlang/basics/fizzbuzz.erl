%% Print FizzBuzz for 1 through 100, choosing the label by matching the remainders.
%% Run: escript fizzbuzz.erl

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
