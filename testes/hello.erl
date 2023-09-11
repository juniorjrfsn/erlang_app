-module(hello).
-export([main/1,usage/0,alooo/1]).

alooo([Name]) -> io:format("Hello, ~s!~n", [Name]).

main([String]) ->
    try
        alooo([String])
    catch
        _:_ -> usage()
    end;
    main(_) -> usage()
.

usage() -> io:format("usage: factorial integer\n"), halt(1).

%% Execucao utilizando a funcao main
%% escript hello.erl "World"

%% Execucao utilizando a funcao diretamente
%% erl -noshell -s hello alooo "World" -s init stop

% $ erl
%Erlang/OTP 27 [DEVELOPMENT] [erts-14.0.2] [source-6ba086ecb1] [64-bit] [smp:6:6] [ds:6:6:10] [async-threads:1] [jit:ns]
%Eshell V14.0.2 (press Ctrl+G to abort, type help(). for help)
% 1> c(hello).
% {ok,hello}
% 2> hello:alooo(["junior como vai !?"]).
% Hello, junior como vai !?!
% ok
