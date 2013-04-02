%%%------------------------------------------------------------------------
%%% @doc Session supervisor, keeps track of active user sessions
%%% Created: 2013-04-02 Dmytro Lytovchenko <kvakvs@yandex.ru>
%%%------------------------------------------------------------------------
-module(wcr_ses_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
child(I, Type, Persistency) ->
    {I, {I, start_link, []}, Persistency, 5000, Type, [I]}.

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
  {ok, { {simple_one_for_one, 5, 10},
         [ child(wcr_ses, worker, transient) ]} }.

%%% Local Variables:
%%% erlang-indent-level: 2
%%% End:
