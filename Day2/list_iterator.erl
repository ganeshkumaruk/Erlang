-module(list_iterator).
-export([iter/1,iter2/1,map/1,filter/1,foldleft/1,foldleft2/1,lang/2,full_price/1]).

iter(Numbers) ->
lists:foreach(fun(Number) -> io:format("~p~n", [Number]) end, Numbers).


iter2(Numbers) ->
Print = fun(X) -> io:format("~p~n", [X]) end,
lists:foreach(Print, Numbers).

map(Numbers) ->
lists:map(fun(X) -> X + 1 end, Numbers).

filter(Numbers) ->
Small = fun(X) -> X < 3 end,
lists:filter(Small, Numbers).

foldleft(Numbers) ->
lists:foldl(fun(X, Sum) -> X + Sum end, 0, Numbers).

foldleft2(Numbers) ->
InitialSum = 0,
Adder = fun(ListItem, SumSoFar) -> ListItem + SumSoFar end,
lists:foldl(Adder, InitialSum, Numbers).

lang(Tuples, Key) ->
  [TupleValue || {TupleKey, TupleValue} <- Tuples, (Key == TupleKey)].

%list_iterator:lang([{erlang, "a functional language"}, {ruby, "an OO language"}], ruby).

full_price(List) ->
  [{Name, Price*Quantity} || {Name, Quantity, Price} <- List].

%list_iterator:full_price([{pencil, 4, 0.25}, {pen, 1, 1.20}, {paper, 2, 0.20}]). 

