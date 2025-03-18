-module(race_conditions).
-export([main/0]).

%% main/0: Starts the counter process and spawns two concurrent increment processes.
main() ->
    %% Start the counter process with an initial value of 0.
    CounterPid = spawn(fun() -> counter_loop(0) end),

    %% Spawn two processes that each increment the counter 1000 times.
    spawn(fun() -> do_increments(CounterPid, 1000) end),
    spawn(fun() -> do_increments(CounterPid, 1000) end),

    %% Give the processes time to finish their increments.
    timer:sleep(3000),

    %% Request the final counter value.
    CounterPid ! {get, self()},
    receive
        {ok, FinalCount} ->
            io:format("Final count: ~p~n", [FinalCount])
    end.

%% counter_loop/1: The counter process loop that maintains state.
%% It receives increment messages and a get request.
counter_loop(Count) ->
    receive
        {increment, _From} ->
            %% Update the counter and continue the loop.
            counter_loop(Count + 1);
        {get, Caller} ->
            %% Reply with the current count.
            Caller ! {ok, Count},
            counter_loop(Count)
    end.

%% do_increments/2: A helper function that sends a given number of increment messages.
do_increments(_Counter, 0) ->
    ok;
do_increments(Counter, N) ->
    %% Send an increment message to the counter process.
    Counter ! {increment, self()},
    do_increments(Counter, N - 1).
