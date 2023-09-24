-module(prime_server).
-behaviour(gen_server).
-export([new_prime/1,start_link/0]).
-export([init/1,handle_call/3]).

start_link() ->
    gen_server:start_link({local,?MODULE},?MODULE,[],[]).

new_prime(N) ->
    gen_server:call(?MODULE,{prime,N},20000).

init([]) ->
    % 要让在程序停止时调用terminate/2，必须设置这个
    process_flag(trap_exit,true),
    io:format("~p starting ~n",[?MODULE]),
    {ok,0}.

handle_call({prime,K},_From,N) ->
    {reply,make_new_prime(K),N+1}.

make_new_prime(K) ->
    if
        K>100 ->
            alarm_handler:set_alarm(tooHot),
            N = lib_primes:make_prime(K),
            alarm_handler:clear_alarm(tooHot),
            N;
        true ->
            lib_primes:make_prime(K)
    end.