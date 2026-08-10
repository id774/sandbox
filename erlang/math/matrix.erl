%% Multiply two fixed 3x3 integer matrices held as lists of lists.
%% Run: escript matrix.erl

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
