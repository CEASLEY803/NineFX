-module(monitor_demo).
-export([start/0, worker/0]).

start() ->
    %% assign the spawned function's PID to our Pid variable, can be very helpful but I dont end up using it here
    Pid = spawn(fun worker/0),
    %% next, assign a reference to the new monitor im creating, need it for my recieve block
    %% process tells erlang what kind of object it's monitoring 
    %% (which is a process in this case. based on what ive read there are lots of different things you can enter here, like port for example)
    Ref = erlang:monitor(process, Pid),
    % Wait for a 'DOWN' message which will be sent when the monitored process terminates.
    receive
        %% '_' before Pid because I will not be using it later.
        %% in this case, DOWN needs 5 parameters {'DOWN', Ref, process, Pid, Reason}.
        {'DOWN', Ref, process, _Pid, Reason} ->
            io:format("Monitored process died with reason: ~p~n", [Reason])
    end.

worker() ->
    io:format("Worker starting...~n"),
    timer:sleep(1000),
    io:format("Worker crashing in 1 second...~n"),
    timer:sleep(1000),
    exit(crash).
