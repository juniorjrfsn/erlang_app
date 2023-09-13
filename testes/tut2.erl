-module(tut2).
-export([convert/2]).

convert(M, inch) ->
    M / 2.54;

convert(N, centimeter) ->
    N * 2.54.
	
% > c(tut2).
% > tut2:convert(3, inch).
 
% > tut2:convert(7, centimeter).