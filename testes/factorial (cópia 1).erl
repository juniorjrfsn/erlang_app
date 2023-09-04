-module(factorial).
-export([main/1, usage/0, fac/1]).
main([String]) ->
    try
        N = list_to_integer(String),
        F = fac(N),
        io:format("factorial ~w = ~w\n", [N,F])
    catch
        _:_ ->
            usage()
    end;
main(_) ->
    usage().

usage() ->
    io:format("usage: factorial integer\n"),
    halt(1).

fac(0) -> 1;
fac(N) -> N * fac(N-1).

%% escript factorial.erl 5
%% erl -noshell -sname factorial -run factorial main 5 -s init stop