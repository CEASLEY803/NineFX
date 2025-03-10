%%%-------------------------------------------------------------------
%% @doc concurrency public API
%% @end
%%%-------------------------------------------------------------------

-module(concurrency_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    io:format("Available apps:~n"),
    io:format("1. message_demo:start()~n"),
    io:format("2. Pid = echo:start().~n   Pid ! \"(your message)\".~n"),
    io:format("3. concurrency_demo:say_hello()~n"),
    concurrency_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
