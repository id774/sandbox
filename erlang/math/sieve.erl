%% Print the primes below 100, sieved by keeping only what no earlier prime divides.
%% Run: escript sieve.erl

-module(sieve).
-export([main/1]).

primes([]) ->
    [];
primes([Prime | Rest]) ->
    [Prime | primes([N || N <- Rest, N rem Prime =/= 0])].

main(_) ->
    Values = [integer_to_list(P) || P <- primes(lists:seq(2, 99))],
    io:format("~s~n", [string:join(Values, " ")]).
