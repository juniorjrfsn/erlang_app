-module(factorial).
-export([main/1, usage/0 ]).
main([String]) ->
    try
        io:format("factorial  ~w\n", [String]),
        io:format("usage: factorial integer\n")
    catch
        _:_ ->
            usage()
    end;
main(_) ->
    usage().

usage() ->
    io:format("usage: factorial integer\n"),
    halt(1).
 

%% escript src/factorial.erl 7
%% erl -noshell -sname factorial -run factorial main 6 -s init stop