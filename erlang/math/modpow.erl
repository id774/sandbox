%% modpow.erl: Modular exponentiation of fixed triples by repeated squaring
%%
%% Description:
%% Print modular powers of fixed triples, each squared and halved by repeated squaring.
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
%%     escript modpow.erl
%%
%% Requirements:
%% - Erlang/OTP 20 or later (escript)
%% - No third-party package is required

-module(modpow).
-export([main/1]).

walk(_Base, 0, _Modulus, Result) ->
    Result;
walk(Base, Exponent, Modulus, Result) ->
    Carried = case Exponent rem 2 of
                  1 -> Result * Base rem Modulus;
                  0 -> Result
              end,
    walk(Base * Base rem Modulus, Exponent div 2, Modulus, Carried).

modpow(Base, Exponent, Modulus) ->
    walk(Base rem Modulus, Exponent, Modulus, 1).

main(_) ->
    Cases = [{2, 1000, 1000003}, {3, 200, 50}, {5, 117, 19}, {10, 18, 9999991}],
    lists:foreach(
        fun({Base, Exponent, Modulus}) ->
            io:format("~w ~w ~w ~w~n", [Base, Exponent, Modulus, modpow(Base, Exponent, Modulus)])
        end,
        Cases
    ).
