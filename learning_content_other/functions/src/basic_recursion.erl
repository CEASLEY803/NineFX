-module(basic_recursion).

-export([factorial/1]).

% N! = N * (N-1)!
factorial(N) when N == 0 -> 1;
factorial(N) when N > 0 -> N * factorial(N-1).