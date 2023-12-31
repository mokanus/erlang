-module(server2).
-export([start/2,rpc/2]).

start(Name,Mod) ->
    register(Name,spawn(fun() -> loop(Name,Mod,Mod:init()) end)).

rpc(Name,Request) ->
    Name ! {self(),Request},
    receive
        {Name,crash} -> exit(rpc);
        {Name,ok,Response} -> Response
    end.

loop(Name,Mod,State) ->
    receive
        {From,Request} ->
            try Mod:handle(Request,State) of
                {Response,NewState} ->
                From ! {Name,ok,Response},
                loop(Name,Mod,NewState)
            catch
                _:Why ->
                    log_the_err(Name,Request,Why),
                    From ! {Name,crash},
                    loop(Name,Mod,State)
            end
    end.

log_the_err(Name,Request,Why) ->
    io:format("server ~p request ~p ~n",
            "caused exception ~p~n",
            [Name,Request,Why]).