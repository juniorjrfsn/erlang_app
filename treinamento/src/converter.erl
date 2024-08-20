-module(converter).
-export([main/1, converter/2]).


% Função para converter uma medida
converter(Formula, Valor) ->
    % Lista de fórmulas de conversão
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
main([Formula, Valor]) when is_atom(Formula), is_number(Valor) ->
    converter(atom_to_list(Formula), Valor);
main(_) ->
    io:format("Uso: conversor {Formula, Valor}.~n").


 %   erl -noshell -pa ./_build/test/lib/treinamento/ebin -s                          converter   main   "CENTIMETROS TO POLEGADAS" 5 -s init stop
 %   erl -noshell -s converter   main   "CENTIMETROS TO POLEGADAS" 5 -s init stop
 %   erl -noshell -pa ./_build/test/lib/treinamento/ebin -s converter main "CENTIMETROS TO POLEGADAS" 5  

% erl -noshell -pa ./_build/test/lib/treinamento/ebin -s                          converter   main   "CENTIMETROS TO POLEGADAS" 5 -s init stop