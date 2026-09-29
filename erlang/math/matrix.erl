%% matrix.erl: Product and determinant of two fixed 3x3 integer matrices
%%
%% Description:
%% Multiply two fixed 3x3 integer matrices held as lists of lists.
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
%%     escript matrix.erl
%%
%% Requirements:
%% - Erlang/OTP 20 or later (escript)
%% - No third-party package is required

-module(matrix).
-export([main/1]).

transpose([[] | _]) ->
    [];
transpose(Matrix) ->
    [[hd(Row) || Row <- Matrix] | transpose([tl(Row) || Row <- Matrix])].

multiply(Left, Right) ->
    Columns = transpose(Right),
    [[lists:sum(lists:zipwith(fun(X, Y) -> X * Y end, Row, Column)) || Column <- Columns]
     || Row <- Left].

determinant([[A, B, C], [D, E, F], [G, H, I]]) ->
    A * (E * I - F * H) - B * (D * I - F * G) + C * (D * H - E * G).

main(_) ->
    Left = [[2, -1, 0], [1, 3, 4], [0, 5, -2]],
    Right = [[1, 0, 2], [-3, 1, 1], [4, 2, 0]],
    Product = multiply(Left, Right),
    lists:foreach(
        fun(Row) ->
            io:format("~s~n", [string:join([integer_to_list(V) || V <- Row], " ")])
        end,
        Product
    ),
    io:format("~w~n", [determinant(Product)]).
