%% First session: transform the counter into a gen_server behavior model, limited to synchronous calls.
%% Second session: implement asynchronous calls.

%% the goal here is to make our counter into the gen_server behavior model.
-module(counter_server).

-behaviour(gen_server).

%% Public API Exports
-export([start_link/0, increment/0, decrement/0, get_count/0, get_word/0, reset/0, crash/0,
         reset_async/0, increment_async/0, decrement_async/0]).
%% gen_server Callback Exports
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2,
         code_change/3]).

%% Public API Functions
start_link() ->
    %% same as the generic server example, but the initial state is 0 (the counter starts at 0)
    gen_server:start_link({local, ?MODULE}, ?MODULE, {0, "Hello"}, []).

%% gen_server:call sends {call, {CallerPid, UniqueRef}, Request} to the server.
increment() ->
    gen_server:call(?MODULE, increment).

increment_async() ->
    gen_server:cast(?MODULE, increment).

decrement() ->
    gen_server:call(?MODULE, decrement).

decrement_async() ->
    gen_server:cast(?MODULE, decrement).

get_count() ->
    gen_server:call(?MODULE, get_count).

get_word() ->
    gen_server:call(?MODULE, get_word).
reset() ->
gen_server:call(?MODULE, reset).

reset_async() ->
    gen_server:cast(?MODULE, reset).

crash() ->
    gen_server:call(?MODULE, crash).


%% init/1:
%% - Called when the server starts.
%% - InitialState is the argument from start_link (here, 0).
%% - Returns {ok, State} with the initial counter value.
init(InitialState) ->
    {ok, InitialState}.

%% gen_server Callback
handle_call(increment, _From, {Counter, Other}) ->
    NewCounter = Counter + 1,
    NewState = {NewCounter, Other},
    {reply, NewCounter, NewState};
handle_call(decrement, _From, {Counter, Other}) ->
    NewCounter = Counter - 1,
    NewState = {NewCounter, Other},
    {reply, NewCounter, NewState};
handle_call(get_count, _From, State) ->
    {reply, element(1, State), State};
handle_call(reset, _From, {_Counter, Other}) ->
    NewState = {0, Other},
    {reply, 0, NewState};
handle_call(get_word, _From, State) ->
    {reply, element(2, State), State};
handle_call(crash, _From, State) ->
    {stop, crash, {error, crash}, State};
handle_call(_Unknown, _From, State) ->
    {reply, {error, unknown}, State}.
    

handle_cast(reset, _State) ->
    {noreply, 0};
handle_cast(increment, {State, Other}) ->
    NewState = State + 1,
    {noreply, {NewState, Other}};
handle_cast(decrement, {State, Other}) ->
    NewState = State - 1,
    {noreply, {NewState, Other}};
handle_cast(_Msg, State) ->
    {noreply, State}.
handle_info(_Info, State) ->
    {noreply, State}.
terminate(_Reason, _State) ->
    ok.
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.