-module(string_words).
-export([list_length/1,count_words/1,count_until/1,count_until/2,print_msg/1]).

list_length([]) -> 0;
list_length(String) ->
  [_ | Tail] = String,
  1 + list_length(Tail).

count_words(Text) ->
  R = re:split(Text, " "),
  list_length(R).

count_until(Val, Max) when Val < Max ->
  io:fwrite("~w~n", [Val]),
  count_until(Val + 1, Max);
count_until(_, Max) ->
  io:fwrite("~w~n", [Max]).

count_until(Max) ->
  count_until(0, Max).

print_msg(success) -> io:fwrite("Success~n");
print_msg({error, Message}) ->
  io:fwrite("Error...: ~s~n", [Message]).
