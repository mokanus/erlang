-module(new_server_new).
-export([]).
-import(server3,[rpc/2]).

% 接口
all_names() -> rpc(name_server,allNames).
add(Name,Place) -> rpc(name_server,{add,Name,Place}).
delete(Name) -> rpc(name_server,{delete,Name}).
find(Name) ->rpc(name_server,{find,Name}).

% 回调
init() -> dict:new().

handle({add,Name,Place},Dict) ->{ok,dict:store(Name,Place,Dict)};
handle(allNames,Dict) -> {dict:fetch_keys(Dict),Dict};
handle({delete,Name},Dict) ->{ok,dict:ease(Name,Dict)};
handle({find,Name},Dict) -> {dict:find(Name,Dict),Dict}.

