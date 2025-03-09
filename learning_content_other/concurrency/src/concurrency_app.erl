%%%-------------------------------------------------------------------
%% @doc concurrency public API
%% @end
%%%-------------------------------------------------------------------

-module(concurrency_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    concurrency_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
