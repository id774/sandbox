
-module(httpdt).
-export([start/0,start/1,handle_connection/1,recv_loop/1]).

start() -> {ok, ListenSocket} = gen_tcp:listen(8080,[{active, false}, binary, {packet, line}, {reuseaddr, true}]),accept(ListenSocket).
start(P) -> {ok, ListenSocket} = gen_tcp:listen(P,[{active, false}, binary, {packet, line}, {reuseaddr, true}]),accept(ListenSocket).

accept(ListenSocket) ->
  {ok, Socket} = gen_tcp:accept(ListenSocket),
  spawn(?MODULE, handle_connection, [Socket]),
  accept(ListenSocket).

handle_connection(Socket) ->
	recv_loop(Socket).

recv_loop(Socket) ->
  case gen_tcp:recv(Socket, 0) of
    {ok, B} ->
      case B of
        <<"GET / HTTP/1.0\r\n">> ->
io:put_chars("GET /time HTTP/1.0\n"),gen_tcp:send(Socket, <<"HTTP/1.0 200 OK\r\nContent-Type: text/html\r\nServer: ErLangDesugaNanikaMonkuAru?/MakedByErLang\r\nConnection: close\r\n\r\n">>),gen_tcp:send(Socket, <<"\r\n<h1>Hello, erlang</h1>\r\n\r\n">>),gen_tcp:close(Socket);
        <<"GET / HTTP/1.1\r\n">> ->
io:put_chars("GET /time HTTP/1.0\n"),gen_tcp:send(Socket, <<"HTTP/1.0 200 OK\r\nContent-Type: text/html\r\nServer: ErLangDesugaNanikaMonkuAru?/MakedByErLang\r\nConnection: close\r\n\r\n">>),gen_tcp:send(Socket, <<"\r\n<h1>Hello, erlang</h1>\r\n\r\n">>),gen_tcp:close(Socket);
        <<"GET /time HTTP/1.0\r\n">> ->
				io:put_chars("GET /time HTTP/1.0\n"),
				gen_tcp:send(Socket, <<"HTTP/1.0 200 OK\r\nContent-Type: text/html\r\nServer: ErLangDesugaNanikaMonkuAru?/MakedByErLang\r\nConnection: close\r\n\r\n">>),
				{{Y,M,D},{Ho,Mi,Se}}=erlang:localtime(),
				gen_tcp:send(Socket, <<"\r\n<h1>time is...</h1>\r\n\r\n">>),
				gen_tcp:send(Socket, integer_to_list(Y)),
				gen_tcp:send(Socket, <<"/">>),
				gen_tcp:send(Socket, integer_to_list(M)),
				gen_tcp:send(Socket, <<"/">>),
				gen_tcp:send(Socket, integer_to_list(D)),
				gen_tcp:send(Socket, <<" ">>),
				gen_tcp:send(Socket, integer_to_list(Ho)),
				gen_tcp:send(Socket, <<":">>),
				gen_tcp:send(Socket, integer_to_list(Mi)),
				gen_tcp:send(Socket, <<":">>),
				gen_tcp:send(Socket, integer_to_list(Se)),
				gen_tcp:close(Socket);
        <<"GET /time HTTP/1.1\r\n">> ->
				io:put_chars("GET /time HTTP/1.0\n"),
				gen_tcp:send(Socket, <<"HTTP/1.0 200 OK\r\nContent-Type: text/html\r\nServer: ErLangDesugaNanikaMonkuAru?/MakedByErLang\r\nConnection: close\r\n\r\n">>),
				gen_tcp:send(Socket, <<"HTTP/1.0 200 OK\r\nContent-Type: text/html\r\nServer: ErLangDesugaNanikaMonkuAru?/MakedByErLang\r\nConnection: close\r\n\r\n">>),
				{{Y,M,D},{Ho,Mi,Se}}=erlang:localtime(),
				gen_tcp:send(Socket, <<"\r\n<h1>time is...</h1>\r\n\r\n">>),
				gen_tcp:send(Socket, integer_to_list(Y)),
				gen_tcp:send(Socket, <<"/">>),
				gen_tcp:send(Socket, integer_to_list(M)),
				gen_tcp:send(Socket, <<"/">>),
				gen_tcp:send(Socket, integer_to_list(D)),
				gen_tcp:send(Socket, <<" ">>),
				gen_tcp:send(Socket, integer_to_list(Ho)),
				gen_tcp:send(Socket, <<":">>),
				gen_tcp:send(Socket, integer_to_list(Mi)),
				gen_tcp:send(Socket, <<":">>),
				gen_tcp:send(Socket, integer_to_list(Se)),
				gen_tcp:close(Socket);
        _ ->
          io:put_chars("Not Found\n"),
          gen_tcp:send(Socket, <<"HTTP/1.0 404 Not Found\r\n\r\n">>),
          recv_loop(Socket)
      end;
    {error, closed} ->
      ok
  end.