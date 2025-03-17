%%%-------------------------------------------------------------------
%% @doc learning_content_other public API
%% @end
%%%-------------------------------------------------------------------

-module(learning_content_other_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    io:format("Available Apps~n"),
    io:format("** Basic Functions & Recursion **~n"),
    io:format("  1. basic_recursion:factorial(N)~n"),
    io:format("  2. greetings:greet(gender, Name)~n"),
    io:format("     Example: greetings:greet(male, \"Cole\").~n"),
    io:format("  3. pixels:extract_rgb(Pixels)~n"),
    io:format("     Example: pixels:extract_rgb(<<255,0,0, 0,255,0, 0,0,255>>).~n~n"),
    
    io:format("** Concurrency & Message Passing **~n"),
    io:format("  4. concurrency_demo:say_hello()~n"),
    io:format("  5. Pid = echo:start(), then Pid ! \"Your message\". enter Q as a message to quit.~n"),
    io:format("  6. message_demo:start()~n~n"),
    
    io:format("** Process Monitoring & Linking **~n"),
    io:format("  7. monitor_demo:start()~n"),
    io:format("  8. link_demo:start()~n~n"),

    io:format("** Combined Concepts **~n"),
    io:format("  9. counter_sup:start_link().~n"),
    io:format("  9. (cont.) counter_server:increment_async(), counter_server:increment(), counter_server:decrement_async(), counter_server:decrement(), counter_server:get_word(),~n"),
    io:format("             counter_server:get_count(), counter_server:reset_async(), counter_server:reset(), counter_server:crash(), counter_server:quit().~n"),
    learning_content_other_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
