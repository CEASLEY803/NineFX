-module(echo).
-export([start/0, loop/0]).

start() ->
    spawn(fun loop/0).

loop() ->
    receive
        Msg ->
            io:format("Received: ~p~n", [Msg]),
            loop()
    end.
