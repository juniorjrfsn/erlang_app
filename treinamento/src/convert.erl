-module(convert).
-export([main/1, usage/0  ]).

usage() ->
    io:format("usage: falha no processamento dos dados\n"),
    halt(1)
.
main([Formula, Valor])-> 
    try 
        io:format("Fórmula = ~s, Valor = ~p ~n", [Formula, Valor]) 
        catch _:_ -> usage()
    end;
    main(_) ->
        io:format("Erro: conversor {Formula, Valor}.~n" )
.



% executar
% erl -noshell -pa ./_build/test/lib/treinamento/ebin -s convert main 'centimetros_to_polegadas' 5 -s init stop
% escript   ./src/convert.erl  'centimetros_to_polegadas' 5

% cd ./_build/test/lib/treinamento/ebin
% c(convert).
% convert:main([{"CENTIMETROS TO POLEGADAS", 5}]).

% compilar
% ../rebar3/rebar3 ct