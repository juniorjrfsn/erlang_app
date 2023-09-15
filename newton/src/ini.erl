-module(ini).
-export([main/1, usage/0]).

main([Mas,Ace,Mas1,Mas2,Dist]) ->
    try
        M = list_to_float(Mas),
        A = list_to_float(Ace),
        N = fisica:forcaN(M,A),
        io:format("A força resultante é: ~p newtons ~n ", [N]),
        Massa1      = list_to_float(Mas1),
        Massa2      = list_to_float(Mas2),
        Distancia   = list_to_float(Dist),
        FG = fisica:forcaG(Massa1,Massa2,Distancia),
        io:format("A força gravitacional é de: ~p newtons ~n ", [FG])
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

% erlc -pa * calc/fisica.erl
% erlc  ini.erl calc/fisica.erl -- windows

%% executar -> ini:main(["100.0", "9.81"]).
%% escript ini.erl 100.0 9.81 80.0 70.0 2.0
%% erl -noshell -sname ini -run ini main 100.0 9.81  -s init stop
%% erl -noshell -sname ini -run ini main "100.0" "9.81"  -s init stop