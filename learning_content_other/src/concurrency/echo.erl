-module(echo).
-export([start/0, loop/0]).

start() ->
    spawn(fun loop/0).
    %% this creates a new process with a PID attatched to it.
    %% Pid = echo:start() assigns that PID to the variable "Pid"
    %% we can use Pid ! "example" to send a message to that PID
    loop() ->
        receive
            "Q" ->
                io:format("Quitting...~n"),
                ok;
            Msg ->
                io:format("Received: ~p~n", [Msg]),
                loop()
        end.