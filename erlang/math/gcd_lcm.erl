%% Print the divisor and multiple of fixed pairs, with Euclid's algorithm written as two clauses.
%% Run: escript gcd_lcm.erl

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
