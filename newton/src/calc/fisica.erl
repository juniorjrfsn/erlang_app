% calc
-module(fisica).
% -compile(export_all).
-export([forcaN/2, forcaG/3]).

forcaN(Massa,Aceleracao)-> (Massa*Aceleracao).

forcaG(Massa1, Massa2,Distancia) ->
    N = 9.81,
    Metro=1,
    Kg=1,
    (6.67408 *10-11*N*math:pow(Metro,2)/math:pow(Kg,2))*((Massa1*Massa2)/ math:pow(Distancia,2))
.