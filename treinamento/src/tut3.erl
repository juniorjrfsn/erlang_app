-module(tut3).
-export([convert/1]).

convert([{"CENTIMETROS TO POLEGADAS", X}]) ->
    {"POLEGADAS", X / 2.54};
convert([{"POLEGADAS TO CENTIMETROS", Y}]) ->
    {"CENTIMETROS", Y * 2.54}.

 

% c(tut3).
% tut3:convert({"POLEGADAS TO CENTIMETROS", 5}).
% tut3:convert({"CENTIMETROS TO POLEGADAS", 5}).
