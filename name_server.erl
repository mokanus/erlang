-module(name_server).
-export([init/0,handle/2,add/2,find/1]).
-import(server2,[rpc/2]).

add(Name,Place) -> rpc(name_server,{add,Name,Place}).
find(Name) -> rpc(name_server,{find,Name}).

% 回调
init() -> dict:new().
handle({add,Name,Place},Dict) -> {ok,dict:store(Name,Place,Dict)};
handle({find,Name},Dict) -> {dict:find(Name,Dict),Dict}.