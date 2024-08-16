-module(treino_consulta).
-export([main/1,usage/0,alooo/1]).

alooo([Name]) -> io:format("Hello, ~s!~n", [Name]).

main([String]) ->
    try
        Texto_treinamento = "
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac justo euismod, 
        suscipit nunc vel, cursus libero. Nullam nec justo at justo tincidunt 
        consectetur. Integer nec odio euismod, vehicula justo id, lacinia libero. 
        ",
            % Hiperparâmetros do Adam
        Alpha = 0.001,  % Taxa de aprendizado
        Beta1 = 0.9,    % Fator de decaimento para o primeiro momento
        Beta2 = 0.999,  % Fator de decaimento para o segundo momento
        Epsilon = 0.000000001, % Pequeno valor para evitar divisão por zero
        M = dict:new(),
        V = dict:new(),
    
        alooo([String])
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

%% erl -compile treino_consulta.erl -s ; erl -noshell -s treino_consulta  alooo "World" -s init stop


%% erl -noshell -s treino_consulta alooo "World" -s init stop
%% erl -compile treino_consulta.erl -s  
%% erl  -noshell -s treino_consulta  alooo "World" -s init stop 

% $ erl
%Erlang/OTP 27 [DEVELOPMENT] [erts-14.0.2] [source-6ba086ecb1] [64-bit] [smp:6:6] [ds:6:6:10] [async-threads:1] [jit:ns]
%Eshell V14.0.2 (press Ctrl+G to abort, type help(). for help)
% 1> c(treino_consulta).
% {ok,treino_consulta}
% 2> treino_consulta:alooo(["junior como vai !?"]).
% Hello, junior como vai !?!
% ok
