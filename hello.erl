-module(hello).
-export([alooo/1]).

alooo([Name]) -> io:format("Hello, ~s!~n", [Name]).

%% erl -noshell -s hello alooo "World" -s init stop