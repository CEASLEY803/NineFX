-module(monitor_demo).
-export([start/0, worker/0]).

start() ->
    Pid = spawn(fun worker/0),
    Ref = erlang:monitor(process, Pid),
    receive
        {'DOWN', Ref, process, _Pid, Reason} ->
            io:format("Monitored process died with reason: ~p~n", [Reason])
    end.

worker() ->
    io:format("Worker starting...~n"),
    timer:sleep(1000),
    io:format("Worker crashing in 1 second...~n"),
    timer:sleep(1000),
    exit(crash).
