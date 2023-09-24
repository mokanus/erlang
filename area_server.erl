-module(area_server).
-export([loop/0]).

loop()->
    receive
        {rectangle,Width,Height} ->
            io:format("Area of rectangle is ~p~n",[Width*Height]),
            loop();
        {square,Side} ->
            io:format("Area of square is ~p~n",[Side*Side]),
            loop()
    end.


sleep()->
    receive
        after 1000->true
    end.
