-module(splite).
-export([odds_and_evensl/1]).

odds_and_evensl(L)->
    Odds = [X || X <-L,(X rem 2) =:=1],
    Evens = [X || X <-L,(X rem 2) =:=0],
    {Odds,Evens}.