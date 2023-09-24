-module(event_handle).
-export([make/1,add_handle/2,event/2]).

make(Name) -> register(Name,spawn(fun()->my_handle(fun no_op/1) end)).

event(Name,X) -> Name ! {event,X}.

add_handle(Name,Fun) -> Name ! {event,Fun}.

my_handle(Fun) ->
    receive
        {add,Fun1} -> 
            my_handle(Fun1);
        {event,Any} ->
            (catch Fun(Any)),
            my_handle(Fun)
    end.

no_op(_) -> void.
