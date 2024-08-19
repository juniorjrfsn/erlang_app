%%%-------------------------------------------------------------------
%% @doc treinamento public API
%% @end
%%%-------------------------------------------------------------------

-module(treinamento_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    treinamento_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
