
-module(pixels).
-export([extract_rgb/1]).

% splits the input into a list of 3-tuples of RGB values
% Example  input: pixels:extract_rgb(<<255, 0, 0,  0, 255, 0,  0, 0, 255>>).
% Example output: extract_rgb(<<255, 0, 0, 0, 255, 0, 0, 0, 255>>) -> [{255, 0, 0}, {0, 255, 0}, {0, 0, 255}]
extract_rgb(Pixels) ->
    [{R, G, B} || <<R:8, G:8, B:8>> <= Pixels].