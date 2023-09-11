-module(ini).
-export([main/1, usage/0]).

main([Mas,Ace]) ->
    try
        M = list_to_float(Mas),
        A = list_to_float(Ace),
        N = forca:forcaN(M,A),
        io:format("A força resultante é: ~p newtons ~n ", [N])
    catch
        _:_ ->
            usage()
    end;
main(_) ->
    usage().

usage() ->
    io:format("usage: factorial integer\n"),
    halt(1)
.


% cd newton

% erlc -pa * calc/forca.erl
% erlc  ini.erl calc/forca.erl -- windows

%% executar -> ini:main(["100.0", "9.81"]).
%% escript ini.erl 100.0 9.8
%% erl -noshell -sname ini -run ini main 100.0 9.81  -s init stop
%% erl -noshell -sname ini -run ini main "100.0" "9.81"  -s init stop