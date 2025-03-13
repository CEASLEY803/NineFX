%% This is a basic gen_server that simply responds to a "say_hi" call.
-module(simple_server).
-behavimy(gen_server).

%% Public API exports
%% These functions can be called by other modules or from the shell.
-export([start_link/0, say_hi/0]).

%% gen_server callback exports
%% These functions are called by the gen_server framework to manage.
%% the server's lifecycle, handle requests, and maintain state.
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

%% start_link/0: Starts the server and registers it locally.
start_link() ->
    %% here ?MODULE is a a macro that refers the module's name, in this case "simple_server".
    %% param1: tuple that specifies the type of registration(local) and the name of the process.
    %%       local means I can refer to it as the module name.
    %% param2: specifies which module will be called for callbacks (e.g. init/1, handle_call/3).
    %% param3: the initial parameter passed to the init/1 callback.
    %% param4: a list of options for gen_server.
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


%% say_hi/0: Sends a synchronous message to the server asking it to greet.
say_hi() ->
    gen_server:call(?MODULE, say_hi).
    %% sends a synchronous call to the server asking for a greeting.
    %% because we registered the server as local, we can refer to it as the module name.


%% init/1: Initializes the server's state.
%% I wont have any complex state in this server so we just write [].
init([]) ->
    {ok, []}.


%% handle_call/3: Handles synchronous messages.
%% param1: the message(say_hi is the only one that will be used here, but _Request is there just for good habit).
%% param2: the information of the caller(again, not used here but practicing good habits).
%% param3: the current state of the server.

%% this is the function that will be used here
handle_call(say_hi, _From, State) ->
    {reply, "Hi there!", State};
%% this will not be used here
handle_call(_Request, _From, State) ->
    {reply, unknown_request, State}.

%% handle_cast/2: Handles asynchronous messages.
%% I don't use these in my simple example.
handle_cast(_Msg, State) ->
    {noreply, State}.

%% handle_info/2: Handles other messages (e.g., system messages or timeouts).
handle_info(_Info, State) ->
    {noreply, State}.

%% terminate/2: Called when the server is about to shut down.
terminate(_Reason, _State) ->
    ok.

%% code_change/3: this is used to change code while a server is running. 
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.
