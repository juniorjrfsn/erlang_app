-module(macro). 
-export([start/0]). 
-define(macro_01(X,Y),{X*Y}). 

start() ->
   io:fwrite("~w",[?macro_01(4,2)])
.
   
   
% > c(macro).
% > macro:start().
 