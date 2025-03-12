-module(concurrency_demo).

-export([say_hello/0, hello/0]).

say_hello() ->
    spawn(fun hello/0).

hello() ->
    io:format("This is a new process~n").
