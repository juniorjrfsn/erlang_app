-module(serverdois).
-behaviour(gen_server).
-export([start/0, stop/0, handle_call/3, handle_cast/2, handle_info/2, init/1]).

% Inicia o servidor web
start() ->    
    {ok, Listen} = gen_tcp:listen(8082, [binary, {packet, 0}, {reuseaddr, true}]), 
    Pid = spawn_link(fun() -> wait_for_connection(Listen) end),
    io:format("Serviço iniciado em http://localhost:8082~nPID: ~w~n", [Pid]),
    {ok, Pid}.

% Aguarda a conexão do cliente
wait_for_connection(Listen) ->
    {ok, Socket} = gen_tcp:accept(Listen),
    spawn(fun() -> handle_request(Socket,"") end),
    wait_for_connection(Listen).

% Manipula a requisição HTTP 
handle_request(Socket, _Data) ->   
    Texto = " Olá galera ! ",
    Response = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<html><body><h1>Bem-vindo ao servidorlang!</h1><p>PID: " ++ erlang:pid_to_list(self()) ++ "<br/>" ++  Texto ++ "</p></body></html>",
    gen_tcp:send(Socket, Response),
    gen_tcp:close(Socket).

% Finaliza o servidor web
stop() ->
    Pid = whereis(serverdois),
    case Pid of
        undefined -> io:format("Server is not running.~n");
        _ -> gen_server:call(Pid, stop)
    end.

% Implementação do gen_server
init([]) -> {ok, server}.
handle_call(_Request, _From, State) -> {noreply, State}.
handle_cast(stop, State) -> {stop, normal, State}.
handle_info(_Info, State) -> {noreply, State}.

%% serverdois:start().
%% serverdois:stop().

%% "GIT BASH" =>  rm -r -f  serverdois.beam	 "WINDOWS" del /f /a  serverdois.beam
%% erlc serverdois.erl
	
		
%% erl -sname serverdois -detached -run serverdois start     -- serverdois:start().
%% erl -sname serverdois -detached -run serverdois stop      -- serverdois:stop().

%% erl -sname serverdois -detached -run serverdois stop
%% erl -sname serverdois -eval 'serverdois:start().'

%% erl -sname serverdois  -noshell -detached -run serverdois  start
%% erl -sname serverdois -noshell -detached -run serverdois stop