%% the goal here is to make our counter into the gen_server behavior model.
-module(counter_server).
-behaviour(gen_server).

%% Public API Exports
-export([start_link/0, increment/0, decrement/0, get_count/0, reset/0, crash/0]).

%% gen_server Callback Exports
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

%% Public API Functions
start_link() ->
    %% same as the generic server example, but the initial state is 0 (the counter starts at 0)
    gen_server:start_link({local, ?MODULE}, ?MODULE, 0, []).

%% gen_server:call sends {call, {CallerPid, UniqueRef}, increment}
increment() ->
    gen_server:call(?MODULE, increment).

decrement() ->
    gen_server:call(?MODULE, decrement).

get_count() ->
    gen_server:call(?MODULE, get).

reset() ->
    gen_server:call(?MODULE, reset).

crash() ->
    gen_server:call(?MODULE, crash).

%% gen_server Callback 

%% init/1:
%% - Called when the server starts.
%% - InitialState is the argument from start_link (here, 0).
%% - Returns {ok, State} with the initial counter value.
init(InitialState) ->
    {ok, InitialState}.

handle_call(increment, _From, State) ->
    %% Increment the counter.
    NewState = State + 1,
    %% {action, reply, state of the server after execution(the new state in this case)}
    {reply, NewState, NewState};

handle_call(decrement, _From, State) ->
    %% Decrement the counter.
    NewState = State - 1,
    %% Reply with NewState and update the state.
    {reply, NewState, NewState};

handle_call(get, _From, State) ->
    %% Return the current counter value.
    {reply, State, State};

handle_call(reset, _From, _State) ->
    %% Reset the counter to 0.
    {reply, 0, 0};

handle_call(crash, _From, State) ->
    %% Simulate a crash: send an error reply and stop the server.
    %% {action, reason, reply, state of the server}
    {stop, crash, {error, crash}, State};

handle_call(Unknown, _From, State) ->
    {reply, {error, Unknown}, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.
