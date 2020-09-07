%%%-------------------------------------------------------------------
%% @doc emitter public API
%% @end
%%%-------------------------------------------------------------------

-module(emitter_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    emitter_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
