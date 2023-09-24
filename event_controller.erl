-module(event_controller).
-export([add_event_handler/0]).

add_event_handler() ->
    event_handle:add_handle(errors,fun controller/1).

controller(too_hot)->
    io:format("turn off the motor");

controller(X) ->
    io:format("~w ignored event: ~p~n",[?MODULE,X]).