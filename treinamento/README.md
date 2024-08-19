#treinamento
=====

## An OTP application


### Build

```
    ## $ ../rebar3/rebar3 ct --suite=test/first_SUITE,test/second_SUITE
    $ ../rebar3/rebar3 ct
```

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



### Create release
```
    ../rebar3/rebar3 new release treinamento
 
```


### Create app
```
    ./rebar3/rebar3 new app treinamento
```