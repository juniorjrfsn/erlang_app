-module(treino_consulta).
-export([get_texto_treinamento/0,main/1,usage/0, pergunta/1]).

pergunta([Entrada]) -> io:format("Olá , ~s!~n", [Entrada]).

get_texto_treinamento() ->
    Texto_treinamento = "
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac justo euismod, 
        suscipit nunc vel, cursus libero. Nullam nec justo at justo tincidunt 
        consectetur. Integer nec odio eumod, vehicula justo id, lacinia libero. 
        ",
    Texto_treinamento
.
main([Entrada]) ->
    try
       %% {Texto_treinamento}  = get_texto_treinamento(),
       %% io:format("Texto_treinamento, ~s!~n", Texto_treinamento),
        pergunta([Entrada])
    catch
        _:_ -> usage()
    end;
    main(_) -> usage()
.

usage() -> io:format("usage: factorial integer\n"), halt(1).

%% Execucao utilizando a funcao main
%% escript treino_consulta.erl "World"

%% Execucao utilizando a funcao diretamente
%% erlc treino_consulta.erl 

%% erl -compile treino_consulta.erl -s ; erl -noshell -s treino_consulta  pergunta "World"  -s init stop

%% erl -noshell -s treino_consulta pergunta "World" -s init stop
%% erl -compile treino_consulta.erl -s  
%% erl  -noshell -s treino_consulta  pergunta "World" -s init stop 

% $ erl
%Erlang/OTP 27 [DEVELOPMENT] [erts-14.0.2] [source-6ba086ecb1] [64-bit] [smp:6:6] [ds:6:6:10] [async-threads:1] [jit:ns]
%Eshell V14.0.2 (press Ctrl+G to abort, type help(). for help)
% 1> c(treino_consulta).
% {ok,treino_consulta}
% 2> treino_consulta:pergunta(["junior como vai !?"]).
% Hello, junior como vai !?!
% ok
