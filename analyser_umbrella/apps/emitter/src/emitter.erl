%%%-------------------------------------------------------------------
%%% @doc This module emits Telemetry events.
%%%
%%% @end
%%%-------------------------------------------------------------------
-module(emitter).

%% API
-export([dispatch_session_count/0]).

dispatch_session_count() ->
    % emit a telemetry event when called
    telemetry:execute([emitter, random_number], #{count => rand:uniform(),
        event => <<"Random event happened!">>}, #{where => ?LINE}).
