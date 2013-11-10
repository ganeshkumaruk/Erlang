-module(string_length).
-export([length/1,f/1]).
%-import(mod,[length/1]).
-compile({no_auto_import,[length/1]}). % erlang:length/1 no longer autoimported

length([]) -> 0;
length([H|T]) -> 1 + length(T). %% Calls the local funtion length/1

f(X) when erlang:length(X) > 33 -> %% Calls erlang:lenght/1,
                                   %% which is allowed in guards

    erlang:length(X);              %% Explicit call to erlang:length in body

f(X) ->
    length(X).                     %% mod:length/1 is called
