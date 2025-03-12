-module(link_demo).
-export([start/0, worker/0]).

start() ->
    spawn_link(fun worker/0).

worker() ->
    io:format("Worker starting...~n"),
    %% crash the app by dividing by 0
    1 div 0.
