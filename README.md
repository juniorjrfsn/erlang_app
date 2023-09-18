# erlang_app
Repositório para exemplos de aplicativos escritos em Erlang


## **Executar uma aplição**
```
    $ cd newton

    $ erlc -pa * calc/fisica.erl
    $ erlc  ini.erl calc/fisica.erl -- windows

    $ executar -> ini:main(["100.0", "9.81"]).
    $ escript ini.erl 100.0 9.81
    $ erl -noshell -sname ini -run ini main 100.0 9.81  -s init stop
    $ erl -noshell -sname ini -run ini main "100.0" "9.81"  -s init stop

```