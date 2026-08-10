%% Print modular powers of fixed triples, each squared and halved by repeated squaring.
%% Run: escript modpow.erl

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
