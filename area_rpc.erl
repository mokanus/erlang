-module(area_rpc).
-export([rpc/2,loop/0]).

rpc(Pid,Request)->
    Pid ! {self(),Request},
    receive
        {Pid,Response} ->
            Response
    end.

loop()->
    receive
        {From,{rectangle,Width,Height}}->
            From ! {self(),Width*Height},
            loop();
        {From,{square,Side}} ->
            From ! {self(),Side*Side},
            loop();
        {From,{circle,R}}->
            From ! {self(),3.1415926 * R *R},
            loop();
        {From,Other} ->
            From ! { self(),{error,Other} },
            loop()
    end.