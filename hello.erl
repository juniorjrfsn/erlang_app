-module(hello).
-export([main/1,usage/0,alooo/1]).

alooo([Name]) -> io:format("Hello, ~s!~n", [Name]).

main([String]) ->
    try
        alooo([String])
    catch
        _:_ -> usage()
    end;
main(_) ->
    usage().

    usage() ->
        io:format("usage: factorial integer\n"),
        halt(1).


%% Execucao utilizando a funcao main
%% escript hello.erl "World"

%% Execucao utilizando a funcao diretamente
%% erl -noshell -s hello alooo "World" -s init stop