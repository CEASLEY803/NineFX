
-module(greetings).

-export([greet/2]).

% have the greet function take two arguments and pick between 3 different greetings based on the input for it's first argument
greet(male, Name) ->
    io:format("Hello, Mr. ~s!~n", [Name]);
greet(female, Name) ->
    io:format("Hello, Ms. ~s!~n", [Name]);
greet(_, Name) ->
    io:format("Hello, ~s!~n", [Name]).
