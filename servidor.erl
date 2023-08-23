%% !/usr/bin/env escript
-module(servidor).
-export([start/0, stop/0, loop/1, do_recv/2]).

start() ->
    {ok, ListenSocket} = gen_tcp:listen(8080, [{reuseaddr, true}]),
	PID = spawn_link(fun() -> loop(ListenSocket) end),
    io:format("Servidor iniciado em http://localhost:8080~n"),
    io:format("PID do servidor: ~p~n", [PID]).

stop() ->
    %% PID = whereis(servidor),
    %% case PID of
    %%   undefined -> io:format("O servidor não está em execução.~n");
    %%    _ -> gen_server:call(PID, stop)
    %% end.

	case whereis(servidor) of
        undefined -> io:format("O servidor não está em execução.~n");
        PID -> exit(PID, kill), io:format("Servidor finalizado.~n")
    end.


loop(ListenSocket) ->
    {ok, AcceptSocket} = gen_tcp:accept(ListenSocket),
    spawn(fun() -> handle_request(AcceptSocket, "") end),
    loop(ListenSocket).

%%handle_request(Socket) ->
%%    Request = read_request(Socket),
%%    Response = generate_response(Request),
%%    gen_tcp:send(Socket, Response),
%%    gen_tcp:close(Socket).


handle_request(Socket, _Data) ->
    Texto = " Olá galera ! ",
    Response = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<html><body><h1>Bem-vindo ao servidorlang!</h1><p>PID: " ++ erlang:pid_to_list(self()) ++ "<br/>" ++  Texto ++ "</p></body></html>",
    gen_tcp:send(Socket, Response),
    gen_tcp:close(Socket).

do_recv(Socket, Bs) ->
    case gen_tcp:recv(Socket, 0) of
        {ok, B} ->
            do_recv(Socket, [Bs, B]);
        {error, closed} ->
            {ok, list_to_binary(Bs)}
    end.



%% erlc servidor.erl

%% servidor:start().
%% servidor:stop().

%% "GIT BASH" =>  rm -r -f  servidor.beam	 "WINDOWS" del /f /a  servidor.beam
%% erlc servidor.erl


%% erl -sname servidor -detached -run servidor start     -- servidor:start().
%% erl -sname servidor -detached -run servidor stop      -- servidor:stop().

%% erl -sname servidor -detached -run servidor stop escript servidor.erl  escript servidor.erl "olá" escript servidor "olá"

%% erl -sname servidor -eval 'servidor:start().'

%% erl -sname servidor  -noshell -detached -run servidor  start
%% erl -sname servidor -noshell -detached -run servidor stop