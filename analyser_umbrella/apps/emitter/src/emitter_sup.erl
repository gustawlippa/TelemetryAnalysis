%%%-------------------------------------------------------------------
%% @doc emitter top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(emitter_sup).

-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%% sup_flags() = #{strategy => strategy(),         % optional
%%                 intensity => non_neg_integer(), % optional
%%                 period => pos_integer()}        % optional
%% child_spec() = #{id => child_id(),       % mandatory
%%                  start => mfargs(),      % mandatory
%%                  restart => restart(),   % optional
%%                  shutdown => shutdown(), % optional
%%                  type => worker(),       % optional
%%                  modules => modules()}   % optional
init([]) ->
    SupFlags = #{strategy => one_for_all,
                 intensity => 0,
                 period => 1},
    ChildSpecs = [
        telemetry_poller:child_spec([{measurements, [{process_info, [{name, my_app_worker},
                                                                     {event, [my_app, worker]},
                                                                     {keys, [memory, message_queue_len]}]},
                                                     {emitter, emit_event, []}]},
                                     {period, 500}, % 500 ms
                                     {name, emitter_poller}
                                    ])
    ],

    %todo for now this
    ok = telemetry:attach(
        %% unique handler id
        <<"log-response-handler">>,
        [emitter, random_number],
        fun log_response_handler:handle_event/4,
        []
    ),

    ok = telemetry:attach_many(
        <<"log-response-handler-vm">>,
        [
            [vm, memory],
            [vm, total_run_queue_lengths],
            [vm, system_counts]
        ],
        fun log_response_handler:handle_event/4,
        []
    ),

    {ok, {SupFlags, ChildSpecs}}.

%% internal functions
