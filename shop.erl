-module(shop).
-export([total/1]).

total([{What,Number}|T])-> shop:cost(What)*Number+total(T);
total([])->0.