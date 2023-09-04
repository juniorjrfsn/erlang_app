%%%-------------------------------------------------------------------
%% @doc sistema public API
%% @end
%%%-------------------------------------------------------------------

-module(sistema_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    sistema_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
