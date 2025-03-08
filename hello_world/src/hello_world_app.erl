-module(hello_world_app).

-behaviour(application).

-export([start/2, stop/1]).

%% start/2 means the function takes two arguments
%%   StartType: Indicates how the application is started (e.g., 'normal' or during a restart).
%%   StartArgs: A list of arguments that can be used during startup.
%% The _ means that the variable is not used intentionally
start(_StartType, _StartArgs) ->
    %% io:format to write to the console, ~n to start a new line
    io:format("Hello, World!~n"),
    %% return {ok, self()} to indicate successful startup
    {ok, self()}.

%% stop/1 means the function takes one argument
%% State: The state of the application provided by Erlang.
stop(_State) ->
    %% return ok to indicate that it closed successfully
    ok.

