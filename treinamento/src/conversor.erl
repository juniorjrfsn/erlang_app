-module(conversor).
-export([main/1, usage/0, converter/1]).

usage() ->
    io:format("usage: falha no processamento dos dados\n"),
    halt(1)
.

converter({Formula, Valor}) -> 
    io:format("A fórmula é: ~p e o valor gerado é ~p~n", [Formula, Valor]),
    case lists:member(Formula, ["CENTIMETROS TO POLEGADAS", "POLEGADAS TO CENTIMETROS"]) of
        true ->
            case Formula of
                "CENTIMETROS TO POLEGADAS" -> {"POLEGADAS", Valor / 2.54};
                "POLEGADAS TO CENTIMETROS" -> {"CENTIMETROS", Valor * 2.54}
            end;
        false ->
            error({badarg, {unknown_unit, Formula}})
    end;
converter(_) -> error({badarg, {invalid_input, "Expected a tuple with unit and value"}}).

main([Formula, Valor]) ->
    try
        % Adicionando depuração para verificar os tipos de entrada
        io:format("Recebido: Fórmula = ~p, Valor = ~p~n", [Formula, Valor]),
        % Convertendo o valor para float
        NumValor = list_to_float(Valor),
        Result = converter({Formula, NumValor}),
        io:format("A fórmula é: ~p e o valor gerado é ~p~n", [Formula, Result])
    catch _:_ -> usage()
    end;
main(_) -> usage().
