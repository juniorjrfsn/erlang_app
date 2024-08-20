-module(converter).
-export([main/1, converter/2]).

usage() ->
    io:format("usage: falha no processamento dos dados\n"),
    halt(1)
.

% Função para converter uma medida
converter(Formula, Valor) ->
    % Lista de fórmulas de conversão
    io:format("Fórmula: ~p Valor: ~p ~n", [Formula, Valor]),
    Formulas = [
        {"centimetros_to_polegadas", 2.54},
        {"polegadas_to_centimetros", 1 / 2.54},
        {"centimetros_to_metros", 0.01},
        {"metros_to_centimetros", 100}
    ], 
    case lists:keyfind(Formula, 1, Formulas) of
        false ->
            io:format("Fórmula inválida: ~p~n", [Formula]);
        {_, Factor} ->
            io:format("~p ~s são ~p ~s.~n",
                     [Valor, Formula, Valor * Factor, lists:nthtail(1, lists:split(string:rfind(Formula, "_"), Formula))])
    end.

% Função principal
main([Formula, Valor])-> 
    try
        % Adicionando depuração para verificar os tipos de entrada
        io:format("Recebido: Fórmula = ~p, Valor = ~p ~n", [Formula, Valor]),
        % Convertendo o valor para float
        %NumValor = list_to_float(Valor),
        Result = converter(Formula, Valor),
        io:format("A fórmula é: ~p e o valor gerado é ~p~n", [Formula, Result])
        catch _:_ -> usage()
    end;
    main(_) ->
        io:format("Uso: conversor {Formula, Valor}.~n" )
.


%   erl -noshell -pa ./_build/test/lib/treinamento/ebin -s                          converter   main   "CENTIMETROS TO POLEGADAS" 5 -s init stop
%   erl -noshell -s converter   main   "CENTIMETROS TO POLEGADAS" 5 -s init stop
%   erl -noshell -pa ./_build/test/lib/treinamento/ebin -s converter main "CENTIMETROS TO POLEGADAS" 5  

%   erl -noshell -pa ./_build/test/lib/treinamento/ebin -s converter   main   "CENTIMETROS TO POLEGADAS" 5 -s init stop

%   erl -noshell -pa ./_build/test/lib/treinamento/ebin -s converter   main   'centimetros_to_polegadas' 5 -s init stop