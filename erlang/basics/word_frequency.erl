%% Count the words of a fixed text, most frequent first and alphabetically within a tie.
%% Run: escript word_frequency.erl

-module(word_frequency).
-export([main/1]).

-define(TEXT, "the quick brown fox jumps over the lazy dog the fox barks").

main(_) ->
    Words = string:lexemes(?TEXT, " "),
    Counts = lists:foldl(
        fun(Word, Acc) -> maps:update_with(Word, fun(N) -> N + 1 end, 1, Acc) end,
        #{},
        Words
    ),
    Ranked = lists:sort(
        fun({WordA, CountA}, {WordB, CountB}) -> {-CountA, WordA} =< {-CountB, WordB} end,
        maps:to_list(Counts)
    ),
    lists:foreach(fun({Word, Count}) -> io:format("~s ~b~n", [Word, Count]) end, Ranked).
