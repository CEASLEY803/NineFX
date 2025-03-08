-module(hello_world_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    io:format("Hello, World!~n"),
    {ok, self()}.

stop(_State) ->
    ok.

