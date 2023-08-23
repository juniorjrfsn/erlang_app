-module(serverlang).

-export([start/0, stop/0, init/0, handle_request/2]).

start() ->
    Pid = spawn(fun() ->
        {ok, ListenSocket} = gen_tcp:listen(8080, [binary, {packet, 0}, {reuseaddr, true}]),
        accept_loop(ListenSocket)
    end),
    register(serverlang, Pid),
    io:format("Server started. PID: ~w~n", [Pid]).

stop() ->
    Pid = whereis(serverlang),
    case Pid of
        undefined -> io:format("Server is not running.~n");
        _ -> gen_server:call(Pid, stop)
    end.

init() ->
    {ok, undefined}.

handle_request(Socket, _Data) ->
    Response = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<html><body><h1>Welcome to the serverlang!</h1><p>PID: " ++ erlang:pid_to_list(self()) ++ "</p></body></html>",
    gen_tcp:send(Socket, Response),
    gen_tcp:close(Socket).

accept_loop(ListenSocket) ->
    {ok, Socket} = gen_tcp:accept(ListenSocket),
    spawn(fun() -> handle_request(Socket, "") end),
    accept_loop(ListenSocket).

%% "GIT BASH" =>  rm -r -f  serverlang.beam	 "WINDOWS" del /f /a  serverlang.beam
%% erlc serverlang.erl


%% erl -sname serverlang -detached -run serverlang start      -- serverlang:start().

%% erl -sname serverlang -detached -run serverlang stop
%% erl -sname serverlang -eval 'serverlang:stop().'


