%% the goal here is to create a process that maintains a counter, can increment, decrement, and report its current value via message passing.
-module(counter).
-export([start/0, increment/1, decrement/1, get_count/1, loop/1, reset/1, quit/1, crash/1]).
%% First session:   implement a basic increment and decrement to learn how to interact with a loop from outside (pattern matching).
%% Second session:  implement a get_count function, a reset function, and an exit function to further reinforce this knowledge.
%% Third session:   implement a manual crash to simulate what happens when something actually does go wrong.
%%                  also added a timeout condition for every function
start() ->
    %% i am using fun() -> here so that the start() function doesn't get stuck-
    %% -waiting for the loop to end: using an anonymous function to do run it seperately.
    %% loop has a single parameter to track how many times it has run, starts at 0.
    spawn(fun() -> loop(0) end).

increment(Pid) ->
    %% Sends {increment, self()} as a tuple to the process specified
    %% 'self()' provides the sender's PID so that the counter can reply.
    Pid ! {increment, self()},
    receive
        {ok, NewCount} -> NewCount
    after 5000 ->
        {error, timeout}
    end.

decrement(Pid) ->
    %% same as increment, just subtracts instead of adds
    Pid ! {decrement, self()},
    receive
        {ok, NewCount} -> NewCount
    after 5000 ->
        {error, timeout}
    end.

get_count(Pid) ->
    %%   Sends a {get, self()} message to the process.
    %%   Waits for a reply {ok, Count} and then returns Count.
    Pid ! {get, self()},
    receive
        {ok, Count} -> Count
    after 5000 ->
        {error, timeout}
    end.

reset(Pid) ->
    Pid ! {reset, self()},
    receive
        {ok, NewCount} -> NewCount
    after 5000 ->
        {error, timeout}
    end.

quit(Pid) ->
    Pid ! {quit, self()},
    receive
        ok -> ok
    after 5000 ->
        {error, timeout}
    end.

crash(Pid) ->
    Pid ! {crash, self()},
    receive
        {error, crashing} -> ok
    after 5000 ->
        {error, timeout}
    end.

loop(Count) ->
    receive
        %% When it recieves the messages sent by the above methods,
        %% it completes what they are intended to inside the loop.

        %% Simply matches the patterns and returns the ok and
        %% the new count back to the functions.
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
        {reset, Caller} ->
            NewCount = 0,
            Caller ! {ok, NewCount},
            loop(NewCount);
        {quit, Caller} ->
            Caller ! ok,
            exit(normal);
        {crash, Caller} ->
            Caller ! {error, crashing},
            exit(crash)
    end.