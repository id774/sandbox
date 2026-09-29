%% word_frequency.erl: Word frequencies of a fixed sentence
%%
%% Description:
%% Count the words of a fixed text, most frequent first and alphabetically within a tie.
%%
%% Part of the basics cross-language exercise set: the input is fixed in the
%% source, and the output is the same as that of the same exercise in every
%% other language. The exercises are specified in README.md at the
%% repository root.
%%
%% Author: id774 (More info: https://id774.net)
%% Source Code: https://github.com/id774/sandbox
%% License: The GPL version 3, or LGPL version 3 (Dual License).
%% Contact: idnanashi@gmail.com
%%
%% Usage:
%%     escript word_frequency.erl
%%
%% Requirements:
%% - Erlang/OTP 20 or later (escript)
%% - No third-party package is required

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
