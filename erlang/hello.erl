%% hello.erl: Greeting from an Erlang module
%%
%% Description:
%% Print a greeting from an Erlang module.
%%
%% Author: id774 (More info: https://id774.net)
%% Source Code: https://github.com/id774/sandbox
%% License: The GPL version 3, or LGPL version 3 (Dual License).
%% Contact: idnanashi@gmail.com
%%
%% Usage:
%%     erlc hello.erl
%%     erl -noshell -s hello hello_world -s init stop
%%
%% Requirements:
%% - Erlang/OTP (erlc and erl)
%%

-module(hello).
-export([hello_world/0]).

hello_world() -> io:fwrite("Hello, World!\n").
