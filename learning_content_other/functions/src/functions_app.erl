%%%-------------------------------------------------------------------
%% @doc functions public API
%% @end
%%%-------------------------------------------------------------------

-module(functions_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    functions_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
