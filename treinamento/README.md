#treinamento
=====

## An OTP application

### Build 
```
    $ ../rebar3/rebar3 compile
    $ ../rebar3/rebar3 shell
    ===> Verifying dependencies...
    ===> Analyzing applications...
    ===> Compiling treinamento
    Erlang/OTP 27 [erts-15.0.1] [source] [64-bit] [smp:12:12] [ds:12:12:10] [async-threads:1] [jit:ns]

    ===> Booted treinamento
    Eshell V15.0.1 (press Ctrl+G to abort, type help(). for help)
    1> r3:async_do(ct).
    
```

### Build

```
    ## $ ../rebar3/rebar3 ct --suite=test/first_SUITE,test/second_SUITE
    $ ../rebar3/rebar3 ct
```

## executar '.BEAM'
``` 
erl -noshell -pa ./_build/test/lib/treinamento/ebin -s                  -run    hello       alooo   "World" -s init stop
erl -noshell -pa ./_build/test/lib/treinamento/ebin -sname  factorial   -run    factorial   main    6       -s init stop
erl -noshell -pa ./_build/test/lib/treinamento/ebin -s                          carros      start   "World" -s init stop

erl -noshell -pa ./_build/test/lib/treinamento/ebin -s                          tut3        convert   "CENTIMETROS TO POLEGADAS" 5 -s init stop
erl -noshell -pa ./_build/test/lib/treinamento/ebin -s                          conversor   main   "CENTIMETROS TO POLEGADAS" 5 -s init stop
erl -noshell -pa ./_build/test/lib/treinamento/ebin -s                          converter   main   "centimetros_to_polegadas" 5 -s init stop
 
 


```




### Apps
To run tests for specific apps only:
```
    $ rebar3 eunit --application=app1,app2
    $ ../rebar3/rebar3  eunit --application=treinamento
    $ ../rebar3/rebar3  eunit --app=treinamento
```


### Files
To run tests for specific files only:

```
    $ ../rebar3/rebar3 eunit --file="_build/test/lib/treinamento/src/hello.erl,_build/test/lib/treinamento/src/hello_world.erl"
    $ ../rebar3/rebar3 eunit --file="src/factorial.erl"  
```
Console
The format is a comma separated list of file paths


### Directories
To run tests for specific directories only:

```
    $ ../rebar3/rebar3 eunit --dir="_build/test/lib/treinamento/ebin/"
```
Console
The format is a comma separated list of directory paths




### Modules
To run tests for specific modules only:
```
    $ ../rebar3/rebar3 eunit --module=hello
    $ ../rebar3/rebar3 eunit --module=hello,hello_world
    $ ../rebar3/rebar3 eunit --module=factorial
```
Console
The format is a comma separated list of module names.

Alias: --suite.

 


### Create release
```
    ../rebar3/rebar3 new release treinamento 
 
```


### Create app
```
    ./rebar3/rebar3 new app treinamento
```