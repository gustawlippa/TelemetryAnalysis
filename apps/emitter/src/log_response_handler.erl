-module(log_response_handler).

-export([handle_event/4]).

-include_lib("kernel/include/logger.hrl").

handle_event([emitter, random_number], #{count := Count, event := Event}, #{where := Path}, _Config) ->
    ?LOG_INFO("[Emitter] Count of ~p is ~p in ~p", [Event, Count, Path]);
handle_event(Event, Measurements, Metadata, _Config) ->
    ?LOG_INFO("[Emitter] Event: ~p", [Event]),
    ?LOG_INFO("[Emitter] Measurements: ~p", [Measurements]),
    ?LOG_INFO("[Emitter] Metadata: ~p", [Metadata]).
