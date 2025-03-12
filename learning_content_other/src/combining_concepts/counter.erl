%% the goal here is to create a process that maintains a counter, can increment, decrement, and report its current value via message passing.
-module(counter).
-export([start/0, increment/1, decrement/1, get_count/1, loop/1, quit/1]).

start() ->
    %% i amusing fun() -> here so that the start() function doesn't get stuck-
    %% -waiting for the loop to end: using an anonymous function to do run it seperately.
    %% loop has a single parameter to track how many times it has run, starts at 0.
    spawn(fun() -> loop(0) end).

increment(Pid) ->
    %% Sends {increment, self()} as a tuple to the process specified
    %% 'self()' provides the sender's PID so that the counter can reply.
    %% Waits for a reply in the form {ok, NewCount} and then returns NewCount.
    Pid ! {increment, self()},
    receive
        {ok, NewCount} -> NewCount
    end.

decrement(Pid) ->
    %% same as increment, just subtracts instead of adds
    Pid ! {decrement, self()},
    receive
        {ok, NewCount} -> NewCount
    end.

get_count(Pid) ->
    %%   Sends a {get, self()} message to the process.
    %%   Waits for a reply {ok, Count} and then returns Count.
    Pid ! {get, self()},
    receive
        {ok, Count} -> Count
    end.

quit(Pid) ->
    Pid ! {quit, self()},
    receive
        ok -> ok
    end.

loop(Count) ->
    receive
        %% When it recieves the messages sent by the above methods, it completes what they are intended to inside the loop.
        %% simply matches the patterns and returns.
        {increment, Caller} ->
            NewCount = Count + 1,
            Caller ! {ok, NewCount},
            loop(NewCount);
        {decrement, Caller} ->
            NewCount = Count - 1,
            Caller ! {ok, NewCount},
            loop(NewCount);
        {get, Caller} ->
            Caller ! {ok, Count},
            loop(Count);
        {quit, Caller} ->
            Caller ! ok,
            exit(normal)
    end.