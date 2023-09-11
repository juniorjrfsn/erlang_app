% calc
-module(forca).
% -compile(export_all). 
-export([forcaN/2]).

forcaN(Massa,Aceleracao)->  
    N = (Massa*Aceleracao),   
    N
.
 
