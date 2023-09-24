

-module(math).
-export([
          sum/1,
          sum/2,
          map/2
        ]).


map(_,[]) -> [];
map(F,[H|T]) -> [F(H)|map(F,T)].


sum(L) -> sum(L,0).

sum([],N) ->N;
sum([H|T],N) ->sum(T,H+N).
