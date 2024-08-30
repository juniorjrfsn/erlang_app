-module(exemplo).
-include_lib("./erlang-sqlite3-1.1.15/include/sqlite3.hrl").
-export([main/0]).

main() ->
    % Inicie o aplicativo SQLite3
    application:start(crypto),
    application:start(erlang_sqlite3),

    % Abra uma conexão com o banco de dados
    {ok, Conn} = sqlite3:open("consciencia/neural.db"),

    % Execute uma consulta
    {ok, Stmt} = sqlite3:prepare(Conn, "SELECT * FROM sua_tabela"),
    {ok, Results} = sqlite3:step(Stmt),

    % Feche a conexão
    sqlite3:close(Conn),

    % Imprima os resultados
    io:format("Resultados: ~p~n", [Results]).