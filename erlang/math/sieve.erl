%% sieve.erl: Primes below 100 by the sieve of Eratosthenes
%%
%% Description:
%% Print the primes below 100, sieved by keeping only what no earlier prime divides.
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
%%     escript sieve.erl
%%
%% Requirements:
%% - Erlang/OTP 20 or later (escript)
%% - No third-party package is required

-module(sieve).
-export([main/1]).

primes([]) ->
    [];
primes([Prime | Rest]) ->
    [Prime | primes([N || N <- Rest, N rem Prime =/= 0])].

main(_) ->
    Values = [integer_to_list(P) || P <- primes(lists:seq(2, 99))],
    io:format("~s~n", [string:join(Values, " ")]).
