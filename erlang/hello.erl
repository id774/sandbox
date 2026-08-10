%% Print a greeting from an Erlang module.

-module(hello).
-export([hello_world/0]).

hello_world() -> io:fwrite("Hello, World!\n").
