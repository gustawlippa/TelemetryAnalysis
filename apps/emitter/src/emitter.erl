%%%-------------------------------------------------------------------
%%% @doc This module emits Telemetry events.
%%%
%%% @end
%%%-------------------------------------------------------------------
-module(emitter).

%% API
-export([emit_event/0, emit_span/0]).

emit_event() ->
    % emit a telemetry event when called
    telemetry:execute([emitter, random_number],
                      #{count => rand:uniform(), event => <<"Random event happened!">>},
                      #{where => ?LINE}).

emit_span() ->
    % emit a telemetry event when called
    telemetry:span([emitter, span],
                   #{where => ?LINE},
                   fun() ->
                       T = round(timer:seconds(1 + rand:uniform())),
                       timer:sleep(T),
                       {{ok, fun_ended}, #{}}
                   % this error emulation is results in the measurements being removed from poller
                   % which is not needed
%%                       case T>1900 of
%%                           true ->
%%                               % emulate an error
%%                               erlang:raise(error, took_too_long, erlang:get_stacktrace());
%%                           false ->
%%                               {{ok, fun_ended}, #{}}
%%                       end
                   end).
