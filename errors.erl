-module(errors).
-export([start/0,start_catch/0,sqrt/1]).

generate_exception(1) -> a;
generate_exception(2) -> throw("throw one error");
generate_exception(3) -> exit("trigger exit signal");
generate_exception(4) -> {'EXIT',"trigger exit narmal"};
generate_exception(5) -> error("error message").

-difine (IP_VERSION,4)

start()->
    [catcher(I) || I <- [1,2,3,4,5]].

start_catch()->
    [{ I,(catch generate_exception(I)) } || I<-[1,2,3,4,5]].

catcher(N)->
    try generate_exception(N) of
        Val -> {N,normal,Val}
    catch
        throw:X -> {N,caught,throw,X};
        exit:X ->  {N,caught,exited,X};
        error:X -> {N,caught,error,X}
    end.

sqrt(X) when X<0 ->
    error({squareRootNegativeArgument,X});
sqrt(X) ->
    math:sqrt(X).

