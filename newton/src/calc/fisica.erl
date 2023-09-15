% calc
-module(fisica).
% -compile(export_all).
-export([forcaN/2,constanteG/0, forcaG/3,forcaGdaTerraEdaLua/0,pesoN/2]).

forcaN(Massa,Aceleracao)-> (Massa*Aceleracao).

constanteG()->
    (
        ((6.67408*math:pow(10,-11))*(5.972*math:pow(10,24)))
        /math:pow((6.371*math:pow(10,6)),2)
    )
.

forcaG(Massa1, Massa2,Distancia) ->
    FG = (
        ( (6.67408 *math:pow(10,-11))* Massa1 * Massa2 )
        /
        math:pow(Distancia,2)
    ),
    [FG,Massa1, Massa2,Distancia]
.
forcaGdaTerraEdaLua() ->
    (
        ((6.67408 *math:pow(10,-11))* (5.972*math:pow(10,24)) * (7.36*math:pow(10,22)) )
        /
        math:pow((3.84*math:pow(10,8)),2)
    )
.

pesoN(Massa, Espace  ) ->
    Newton = case Espace of
        "Sol"   -> (Massa * 274.13);
        "Terra" -> (Massa * 9.819649737724951);
        "Lua"   -> (Massa * 1.625);
        "Marte" -> (Massa * 3.72076);
         _      ->  1
    end,
    Lugar = case Espace of
        "Sol"   -> "no Sol";
        "Terra" -> "na Terra";
        "Lua"   -> "na Lua";
        "Marte" -> "em Marte";
         _      ->  "..."
    end,
    {Newton, Massa, Lugar}
.

%% TERRA e lua
%% escript ini.erl 100.0 9.81 80.0 70.0 2.0