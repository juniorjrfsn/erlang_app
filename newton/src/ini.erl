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
        Fg = fisica:forcaG(Massa1,Massa2,Distancia),
        io:format("A força gravitacional (forcaG) de Massa1 ~p, Massa2 ~p e Distancia ~p é de: ~p newtons ~n ", [
                lists:nth(2, Fg)
                , lists:nth(3, Fg)
                , lists:nth(4, Fg)
                , lists:nth(1, Fg)
            ]
        ),
        GravidadeTerra = fisica:constanteG(),
        io:format("A força gravitacional da terra é de: ~p m/s² ~n ", [GravidadeTerra]),
        GravidadeTerraLua = fisica:forcaGdaTerraEdaLua(),
        io:format("A força gravitacional da terra e da Lua é de: ~p N ~n ", [GravidadeTerraLua]),
        {Newton, Massa, Lugar} = fisica:pesoN(M,"Terra"),
        io:format("O peso é ~.2f N, para a massa de ~.2f kg ~s.~n", [Newton, Massa, Lugar])
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

%% gravidade
%% escript ini.erl 100.0 9.81 2000000.0 3000000.0 4.0