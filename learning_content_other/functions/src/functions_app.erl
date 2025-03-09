%%%-------------------------------------------------------------------
%% @doc functions public API
%% @end
%%%-------------------------------------------------------------------

-module(functions_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    io:format("Available apps:~n"),
    io:format("1. greetings:greet(gender, name in quotes)- enter gender in lowercase~n"),
    io:format("2. basic_recursion:factorial(N)~n"),
    io:format("3. pixels:extract_rgb(Pixels)- Ex: <<255, 0, 0, 0, 255, 0, 0, 0, 255>>~n"),
    functions_sup:start_link().


stop(_State) ->
    ok.

%% internal functions
