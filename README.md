# erlang_app
Repositório para exemplos de aplicativos escritos em Erlang

## **Exemplo de aplicação em Erlang**
```
https://epsi.bitbucket.io/lambda/2020/11/10/playing-with-records-erlang/
```

## **Executar uma aplição**
```
    $ cd newton/src/

    $ erlc -pa * calc/fisica.erl
    $ erlc  ini.erl calc/fisica.erl -- windows

        executar no interative
    $ erl
        Erlang/OTP 26 [erts-14.0.2] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit:ns]

        Eshell V14.0.2 (press Ctrl+G to abort, type help(). for help)
        1> c("ini"). c("calc/fisica").
        2> ini:main(["100.0", "9.81", "2000000.0", "3000000.0", "4.0" ]).

    $ escript ini.erl 100.0 9.81 2000000.0 3000000.0 4.0
    $ erl -noshell -sname ini -run ini main 100.0 9.81 2000000.0 3000000.0 4.0  -s init stop
    $ erl -noshell -sname ini -run ini main "100.0" "9.81" "2000000.0" "3000000.0" "4.0"  -s init stop

    $ escript ini.erl 100.0 9.81 2000000.0 3000000.0 4.0

```