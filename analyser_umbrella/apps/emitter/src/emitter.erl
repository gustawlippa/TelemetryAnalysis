%%%-------------------------------------------------------------------
%%% @doc This module emits Telemetry events.
%%%
%%% @end
%%%-------------------------------------------------------------------
-module(emitter).

%% API
-export([emit_event/0]).

emit_event() ->
    % emit a telemetry event when called
    telemetry:execute([emitter, random_number],
                      #{count => rand:uniform(), event => <<"Random event happened!">>},
                      #{where => ?LINE}).
