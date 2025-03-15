%% this supervisor is responsible for starting and monitoring the counter_server process. 
%% at any point if the counter_server process crashes, the supervisor will restart it(up to 5 times in 10 seconds).

-module(counter_sup).
-behaviour(supervisor).

%% Public API Export 
-export([start_link/0]).
%% Supervisor Callback Export
-export([init/1]).

%% Public API Functions

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% init/1:
init([]) ->
    %% {Id, StartFunc, Restart, Shutdown, Type, Modules}
    %% Id: A unique identifier for the child (often the module name).
    %% StartFunc: A tuple {Module, Function, Args} to start the child process.
    %% Restart: How the supervisor should handle restarts (e.g. permanent).
    %% Shutdown: How to shut down the child (5000 ms, infinity, etc.).
    %% Type: The type of process (worker or supervisor).
    %% Modules: A list of modules that define the child process.
    ChildSpec = {
        counter_server,                %% Id: using counter_server as identifier.
        {counter_server, start_link, []}, %% Start Function: calls counter_server:start_link().
        permanent,                     %% Restart: always restart the child if it terminates.
        5000,                          %% Shutdown: allow 5000 ms before killing.
        worker,                        %% Type: This is a worker process.
        [counter_server]               %% Modules: The child is implemented by counter_server module.
    },

    %% Define the supervisor's strategy.
    %% one_for_one: If a child process crashes, only that process is restarted.
    %% {ok, {{one_for_one, 5, 10}, [ChildSpec]}}: Restart the child up to 5 times in 10 seconds.
    {ok, {{one_for_one, 5, 10}, [ChildSpec]}}.
