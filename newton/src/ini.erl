-module(ini).
-export([main/1, usage/0]).

main([Mas,Ace,Mas1,Mas2,Dist]) ->
    try
        % Força gravitacional entre dois corpos
        M = list_to_float(Mas),
        A = list_to_float(Ace),
        N = fisica:forcaN(M,A),
        io:format("A força aplicada é: ~pN para uma massa de ~pKg e uma aceleração de ~pm/s ~n ", [N,M,A]),

        % Força gravitacional entre dois corpos
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

        % Aceleraçção gravitacional na terra
        GravidadeTerra = fisica:constanteG(),
        io:format("A força gravitacional da terra é de: ~p m/s² ~n ", [GravidadeTerra]),

        % Força gravitaciona entre a terra e a lua
        GravidadeTerraLua = fisica:forcaGdaTerraEdaLua(),
        io:format("A força gravitacional da terra e da Lua é de: ~p N ~n ", [GravidadeTerraLua]),

        % Peso de um corpo em relação a gravidade de algum corpo celeste
        {Caso, Massa, Lugar} = fisica:pesoN(M,"Lua"),
        {Aceleracao,Corpoceleste,Newton} = Caso,
        io:format("Corpo : ~p , Gravidade: ~p ~n ", [Corpoceleste,Aceleracao]),
        io:format("O peso é ~.2f N, para a massa de ~.2f kg ~s.~n", [Newton, Massa, Lugar]),

        % Energia cinetica
        Velocidade  = 20,
        CorpoInerte = 10,
        {J,{MasssaInerte,Velocidade}} = fisica:energiaCinetica(CorpoInerte,Velocidade),
        io:format("A energia cinética é de  ~p Joules para uma massa de ~p  e Velocidade de ~pm/s ~n ", [J,MasssaInerte,Velocidade])
    catch _:_ -> usage()
    end;
main(_) -> usage().

usage() ->
    io:format("usage: falha no processamento dos dados\n"),
    halt(1)
.


% cd newton

% erlc -pa * calc/fisica.erl
% erlc  ini.erl calc/fisica.erl -- windows

%% executar -> ini:main(["100.0", "9.81"]).
%% escript ini.erl 100.0 9.81 2000000.0 3000000.0 4.0
%% erl -noshell -sname ini -run ini main 100.0 9.81 2000000.0 3000000.0 4.0  -s init stop
%% erl -noshell -sname ini -run ini main "100.0" "9.81" "2000000.0" "3000000.0" "4.0"  -s init stop


%% escript ini.erl 100.0 9.81 2000000.0 3000000.0 4.0