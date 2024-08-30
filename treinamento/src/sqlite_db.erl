-module(sqlite_db).
-include_lib("./erlang-sqlite3-1.1.15/include/sqlite3.hrl").
%-export([open_db/1   ]).

-export([main/1, usage/0  ]).

usage() ->
    io:format("usage: falha no processamento dos dados\n"),
    halt(1)
.
main([Formula, Valor])-> 
    try 
        io:format("Fórmula = ~s, Valor = ~p ~n", [Formula, Valor])
        % , application:start(crypto)
        % , application:start(erlang_sqlite3) 
        % , {ok, Conn} = sqlite3:open("consciencia/neural.db")
        % , io:format("Conexao =  ~p ~n", [Conn])
        catch _:_ -> usage()
    end;
    main(_) ->
        io:format("Erro: conversor {Formula, Valor}.~n" )
.


% compilar
% ../rebar3/rebar3 ct

% executar

% ../../rebar3/rebar3 ct
% erl -noshell -pa ../_build/test/lib/treinamento/ebin -s sqlite_db main 'centimetros_to_polegadas' 5 -s init stop
% escript   ./sqlite_db.erl  'centimetros_to_polegadas' 5

% erl -noshell -pa ../_build/test/lib/treinamento/ebin -s sqlite_db main 'centimetros_to_polegadas' 5 -s init stop
% escript   ./src/sqlite_db.erl  'centimetros_to_polegadas' 5
