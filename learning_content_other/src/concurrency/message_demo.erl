-module(message_demo).
-export([start/0, receiver/0]).

start() ->
    %% Spawn a new process that runs the receiver function.
    Pid = spawn(fun receiver/0),
    %% Send a message to the spawned process.
    Pid ! {hello, "Cole"}.

receiver() ->
    %% Wait for a message.
    receive
        {hello, Who} ->
            io:format("Received hello message, hello ~s!~n", [Who])
    end.
